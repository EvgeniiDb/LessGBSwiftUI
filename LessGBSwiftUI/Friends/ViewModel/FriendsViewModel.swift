//
//  FriendsViewModel.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 01.09.2022.
//

import UIKit.UIImage

/// Протокол вью модели для контроллера Friends
protocol FriendsViewModelType {
    
    /// Список друзей текущего пользователя
    var friends: [FriendsSection] { get }
    
    /// Cписок друзей текущего пользователя, которые подходят под поисковой запрос
    var filteredData: [FriendsSection] { get }
    
    /// Сервис по загрузке данных пользователей
    var loader: UserLoader { get }
    
    /// Скачиваем из сети список друзей пользователя
    func fetchFriends(completion: @escaping () -> Void)
    
    /// Осуществляет поиск друзей среди списка друзей пользователя по введённому тексту
    func search(_ text: String, completion: @escaping () -> Void)
    
    /// Осуществляет действия после нажатия кнопки отмены поиска
    func cancelSearch(completion: @escaping() -> Void)
}

/// Вью модель для контроллера Friends
final class FriendsViewModel: FriendsViewModelType, ObservableObject {
    var objectWillChange = ObjectWillChangePublisher()
    
    var filteredData: [FriendsSection] = []
    var friends: [FriendsSection] = []
    
    var loader: UserLoader
    
    init(loader: UserLoader){
        self.loader = loader
    }
    
    func fetchFriends(completion: @escaping () -> Void) {
        loader.loadFriends() { [weak self] friends in
            self?.friends = friends
            self?.filteredData = friends
            self?.objectWillChange.send()
        }
    }
    
    func search(_ text: String, completion: @escaping () -> Void) {
        
        //занулим для повторных поисков
        filteredData = []
        
        // Если поиск пустой, то ничего фильтровать нам не нужно
        if text == "" {
            filteredData = friends
        } else {
            for section in friends { // сначала перебираем массив секций с друзьями
                for (_, friend) in section.data.enumerated() { // потом перебираем массивы друзей в секциях
                    if friend.name.lowercased().contains(text.lowercased()) { // Ищем в имени нужный текст, оба текста сравниваем в нижнем регистре
                        var searchedSection = section
                        
                        // Если фильтр пустой, то можно сразу добавлять
                        if filteredData.isEmpty {
                            searchedSection.data = [friend]
                            filteredData.append(searchedSection)
                        } else {
                            
                            // Если в массиве секций уже есть секция с таким ключом, то нужно к имеющемуся массиву друзей добавить друга
                            var found = false
                            for (sectionIndex, filteredSection) in filteredData.enumerated() {
                                if filteredSection.key == section.key {
                                    filteredData[sectionIndex].data.append(friend)
                                    found = true
                                    break
                                }
                            }
                            
                            // Если такого ключа ещё нет, то создаём новый массив с нашим найденным другом
                            if !found {
                                searchedSection.data = [friend]
                                filteredData.append(searchedSection)
                            }
                        }
                    }
                }
            }
        }
        objectWillChange.send()
    }
    
    func cancelSearch(completion: @escaping () -> Void) {
        filteredData = friends
    }
}

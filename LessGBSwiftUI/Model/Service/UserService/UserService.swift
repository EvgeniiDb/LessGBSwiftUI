//
//  UserService.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 29.08.2022.
//

//import UIKit.UIImage
//
//
//protocol UserLoader: Loader {
//    
//    // список друзей
//    func loadFriends(completion: @escaping ([FriendsSection]) -> Void)
//    
//    // все фото пользователя
//    func loadUserPhotos(for id: String, completion: @escaping ([ApiImage]) -> Void)
//    
//    // Запрос кол-во друзей пользователя
//    func getFriendsCount(completion: @escaping (Int) -> Void)
//}
//
//
//final class UserService: UserLoader {
//    
//    internal var networkManager: NetworkManagerInterface
////    internal var cache: ImageCache
////    internal var persistence: PersistenceManager
//    
//    
//    let cacheKey = "usersExpiry"
//    
//    required init(networkManager: NetworkManagerInterface) {
//        self.networkManager = networkManager
//    }
//    
//    
//    private var friendsArray: [Friend]?
//    
//   
//    private func sortFriends(_ array: [Friend]) -> [Character: [Friend]] {
//        
//        var newArray: [Character: [Friend]] = [:]
//        for user in array {
//            
//            guard let firstChar = user.name.first else {
//                continue
//            }
//            
//         
//            guard var array = newArray[firstChar] else {
//                let newValue = [user]
//                newArray.updateValue(newValue, forKey: firstChar)
//                continue
//            }
//            
//         
//            array.append(user)
//            newArray.updateValue(array, forKey: firstChar)
//        }
//        return newArray
//    }
//    
//    private func formFriendsSections(_ array: [Character: [Friend]]) -> [FriendsSection] {
//        var sectionsArray: [FriendsSection] = []
//        for (key, array) in array {
//            sectionsArray.append(FriendsSection(key: key, data: array))
//        }
//        
//     
//        sectionsArray.sort { $0 < $1 }
//        
//        return sectionsArray
//    }
//    
//    private func formFriendsArray(from array: [Friend]?) -> [FriendsSection] {
//        guard let array = array else {
//            return []
//        }
//        let sorted = sortFriends(array)
//        return formFriendsSections(sorted)
//    }
//    
//    
//    // Загружает список друзей
//    func loadFriends(completion: @escaping ([FriendsSection]) -> Void) {
//        let params = [
//            "order" : "name",
//            "fields" : "photo_100",
//        ]
//        
//        networkManager.request(method: .friendsGet,
//                               httpMethod: .get,
//                               params: params) { [weak self] (result: Result<VkFriendsMainResponse, Error>) in
//            switch result {
//            case .success(let friendsResponse):
//                let friends = friendsResponse.response.items
//                //self?.persistence.create(friends) { _ in }
//                
//                guard let sections = self?.formFriendsArray(from: friends) else {
//                    return
//                }
//                
//                // Ставим дату просрочки данных
//                if let cacheKey = self?.cacheKey {
//                    self?.setExpiry(key: cacheKey, time: 10 * 60)
//                }
//                
//                completion(sections)
//            case .failure(let error):
//                debugPrint("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//
//    func getFriendsCount(completion: @escaping (Int) -> Void) {
//        networkManager.request(method: .friendsGet,
//                               httpMethod: .get,
//                               params: [:]) { (result: Result<FriendsCountMainResponse, Error>) in
//            switch result {
//            case .success(let friendsResponse):
//                completion(friendsResponse.response.count)
//            case .failure(let error):
//                debugPrint("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    // Загрузка все фото пользователя
//    func loadUserPhotos(for id: String, completion: @escaping ([ApiImage]) -> Void) {
//        let params = [
//            "owner_id" : id,
//            "count": "50",
//        ]
//        networkManager.request(method: .photosGetAll,
//                               httpMethod: .get,
//                               params: params) { (result: Result<UserImagesMainResponse, Error>) in
//            switch result {
//            case .success(let imagesResponse):
//                let imagesModels = imagesResponse.response.items
//                completion(imagesModels)
//            case .failure(_):
//                break
//            }
//        }
//    }
//}


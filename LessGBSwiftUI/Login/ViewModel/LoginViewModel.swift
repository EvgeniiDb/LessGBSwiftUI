//
//  LoginViewModel.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 24.08.2022.
//

import Combine

/// Вью модель авторизации
final class LoginViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    func authorize() {
        if self.isLoggedIn == false {
            self.isLoggedIn = true
        }
    }
    
    // Разлогин пользователя
    func logOut() {
        Session.instance.clean()
        self.isLoggedIn = false
    }
}

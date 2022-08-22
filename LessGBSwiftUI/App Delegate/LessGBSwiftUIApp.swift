//
//  LessGBSwiftUIApp.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 27.07.2022.
//

import SwiftUI

@main
struct LessGBSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(isLoggedIn: .constant(false))
            //MainScreen()
            //LoginView(isLoggedIn: .constant(true))
            //FriendsList()
        }
    }
}

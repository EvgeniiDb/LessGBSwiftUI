//
//  Session.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 24.08.2022.
//

import Foundation
import WebKit

// Класс для хранения данных авторизации, Singleton
final class Session {
    
    var token: String?
    var userID: Int?
    
    static let instance = Session()
    
    private init() {}
    
    // Сохранение данных авторизации пользователя
    func loginUser(with token: String, userId: Int) {
        self.token = token
        self.userID = userId
        print("Token: \(token)")
    }
    
    func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        
        UserDefaults.standard.removeObject(forKey: "vkToken")
    }
}


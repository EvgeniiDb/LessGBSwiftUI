//
//  UserModel.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import RealmSwift
import Foundation

// Модель пользователя
class UserModel: Object, NewsSourceProtocol, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var id: Int = 0
    
    // Перечисление соответствия полям в АПИ к полям в нашей модели
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case image = "photo_100"
        case id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name", "image"]
    }
}

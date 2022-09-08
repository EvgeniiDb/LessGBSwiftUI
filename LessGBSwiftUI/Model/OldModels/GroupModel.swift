//
//  GroupModel.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import RealmSwift
import Foundation

// Модель группы Вконтакте
class GroupModel: Object, NewsSourceProtocol, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var isMember: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case image = "photo_50"
        case isMember = "is_member"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

//
//  Friend.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 01.09.2022.
//

import Foundation

// Модель друга
struct Friend: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String
    
    var imageUrl: URL? {
        URL(string: image)
    }

    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case image = "photo_100"
        case id
    }
}


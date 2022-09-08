//
//  FriendImage.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 01.09.2022.
//

import Foundation

// Модель картинки галереи пользователя
struct FriendImage: Identifiable {
    var id: String { link }
    let link: String
    
    var imageUrl: URL? {
        URL(string: link)
    }
}

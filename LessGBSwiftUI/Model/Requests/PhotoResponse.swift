//
//  PhotoResponse.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

// Ответ API про фото у новости
struct Photos: Codable {
    let count: Int
    let items: [ApiImage]
}

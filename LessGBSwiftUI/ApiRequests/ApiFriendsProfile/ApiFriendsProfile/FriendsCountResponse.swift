//
//  FriendsCountResponse.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 01.09.2022.
//

// Cтруктура стандартного ответа API ВK по запросу друзей
struct FriendsCountResponse: Codable {
    let count: Int
    let items: [Int]
}

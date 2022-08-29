//
//  UserImagesResponse.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 29.08.2022.
//

struct UserImagesResponse: Codable {
    let count: Int
    let items: [ApiImage]
}

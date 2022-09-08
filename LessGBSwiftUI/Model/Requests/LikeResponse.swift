//
//  LikeResponse.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import Foundation


struct LikesResponse: Codable {
    let response: LikesCount
}

struct LikesCount: Codable {
    let likes: Int
}

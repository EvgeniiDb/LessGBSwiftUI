//
//  NewsMainRequest.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

// Основной ответ от АПИ при запросе новостей
struct NewsMainResponse: Codable {
    let response: NewsContentsResponse
}

struct NewsContentsResponse: Codable {
    let items: [NewsModel]
    let profiles: [UserModel]
    let groups: [GroupModel]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}


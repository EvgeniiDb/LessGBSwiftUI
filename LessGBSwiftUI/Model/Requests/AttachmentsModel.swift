//
//  AttachmentsModel.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import Foundation


/// Модель для получения описания приложения к посту
struct AttachmentsModel: Codable {
    let type: String
    let link: Link?
    let photo: ApiImage?
    let video: Video?
}

/// Модель для получения данных приложения к посту типа CСЫЛКА
struct Link: Codable {
    let url: String
    let title, linkDescription: String
    let caption: String?
    let photo: ApiImage?

    enum CodingKeys: String, CodingKey {
        case url, title
        case caption
        case linkDescription = "description"
        case photo
    }
}

/// Модель для доступа к приложению  к посту вида Видео
struct Video: Codable {
    let firstFrame: [VideoPreview]?
    let photo: [VideoPreview]?
    
    enum CodingKeys: String, CodingKey {
        case firstFrame = "first_frame"
        case photo = "image"
    }
}

/// Модель картинки превью для приложения вида Видео
struct VideoPreview: Codable {
    let url: String
    let width: Int
    let height: Int
}

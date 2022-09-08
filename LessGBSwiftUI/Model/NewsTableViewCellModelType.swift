//
//  NewsTableViewCellModelType.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit.UIImage

// Протокол модели табличной ячейки новостей
protocol NewsTableViewCellModelType {
    var source: NewsSourceProtocol { get }
    var likesModel: LikesModel? { get }
    var views: Views? { get }
    var comments: CommentsModel? { get }
    var reposts: RepostsModel? { get }
    var postID: Int { get }
    var postDate: String { get }
    var date: Double { get }
    var postText: String { get }
    var shortText: String? { get }
    var newsImageModels: [Sizes] { get }
    var collection: [UIImage] { get }
    var link: Link? { get }
}

//
//  NewsSourceProtocol.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

// Протокол, описывающий создателя новости
protocol NewsSourceProtocol {
    var name: String { get set }
    var image: String { get set }
    var id: Int { get set }
}

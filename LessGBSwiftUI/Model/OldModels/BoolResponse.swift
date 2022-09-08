//
//  BoolResponse.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

// Ответ, который подразумевает булевый response, но не true/false, а 1/0
struct BoolResponse: Codable {
    var response: Int
}


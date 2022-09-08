//
//  NewsUIKitView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import SwiftUI

/// Вью для отображения UIKit Контроллера новостей
struct NewsUIKitView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> NewsController {
        
        // Вот такая сборка это костыль, понимаю, это для упрощения
        let networkManager = NetworkManager()
        let loader = NewsService(networkManager: networkManager)
        let model = NewsViewModel(loader: loader)
        let controller = NewsController(model: model)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: NewsController, context: Context) { }
}

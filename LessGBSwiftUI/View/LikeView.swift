//
//  LikeView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 02.09.2022.
//

import SwiftUI

// Вью для отображения лайков
struct LikeView: View {
    
    // Флаг сердечка
    @Binding var likeFlag: Bool
    
    // Кол-во лайков фото
    var likesCount: Int
    
    var body: some View {
        
        HStack {
            Text(String(likesCount))
            
            if likeFlag {
                Image(systemName: "heart.fill")
            } else {
                Image(systemName: "heart")
            }
        }
    }
}


//
//  FriendListCell.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 04.08.2022.
//

import SwiftUI

struct FriendListCell: View {
    
    private var text: String
    private var image: String
    
    init(imageUrl: String, textCell: String) {
        self.text = textCell
        self.image = imageUrl
    }
    
    var body: some View {
        HStack {
            Image(image)
                .imgStyle(100)
            
            Text(text)
                .lineLimit(5)
                .padding()
        }
    }
    
}

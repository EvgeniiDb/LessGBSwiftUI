//
//  ImgModifier.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 04.08.2022.
//

import SwiftUI

struct ImgAvatar: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.main,
                        lineWidth: 1))
            .shadow(radius:10)
    }
}

extension Image {
    func imgStyle(_ size: Double) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size, alignment: .center)
            .modifier(ImgAvatar())
    }
}

extension Color {
    static let main = Color("main")
}

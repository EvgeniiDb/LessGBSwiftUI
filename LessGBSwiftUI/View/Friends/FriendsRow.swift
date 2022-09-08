//
//  FriendsRow.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 02.09.2022.
//

import SwiftUI
import Kingfisher

// Вью для отображения данных друга в списке
struct FriendsRow: View {
    
    // Модель друга
    let friend: Friend
    
 
    @State var clickedState: Bool = false
    @State var isScaled: Bool = false

    //@State private var isRotated = false
    @State private var isAnimationOn = false
    
    var body: some View {
        HStack {
            KFImage(friend.imageUrl)
            
                .resizable()
                .frame(width: 50, height: 50, alignment: .leading)
                .cornerRadius(25)
                .shadow(radius: 5)
                .scaleEffect(isScaled ? 1.2 : 1.0)
                .onTapGesture {
                    clickedState.toggle()

                    withAnimation(.interpolatingSpring(stiffness: 40, damping: 4, initialVelocity: 70)) {
                        isScaled.toggle()
                    }
                }
            
            Text(friend.name)
                .padding([.leading])
        }
    }
}


struct FriendsRow_Previews: PreviewProvider {
    
    static var friend = Friend(id: 0, name: "Kaha", image: "")
    
    static var previews: some View {
        FriendsRow(friend: friend)
    }
}

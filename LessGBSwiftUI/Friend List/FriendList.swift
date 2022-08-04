//
//  FriendList.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 04.08.2022.
//

import SwiftUI

struct FriendList: View {
    var body: some View {
        VStack {
            Text("Friends")
                .font(.title)
            List(0..<30) { _ in
                FriendListCell(imageUrl: "YC", textCell: "Великий Юлий Цезарь")
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct FriendList_Previews: PreviewProvider {
    static var previews: some View {
        FriendList()
    }
}

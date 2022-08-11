//
//  FriendPhotoCollection.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 12.08.2022.
//

import SwiftUI

import SwiftUI

struct FriendPhotosCollection: View {
    var nameFriend: String

    var body: some View {
        VStack {}
        .navigationTitle("Photo \(nameFriend)")
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosCollection(nameFriend: "Великий Юлий Цезарь")
    }
}


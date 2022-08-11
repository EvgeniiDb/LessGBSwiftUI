//
//  FriendList.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 04.08.2022.
//

import SwiftUI


struct FriendsList: View {
    @State private var friendsSection = [
        ["Великий Юлий Цезарь", "Великий Юлий Цезарь"],
        ["Великий Юлий Цезарь"]
    ]

    var body: some View {
        NavigationView {
            friendsList
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: EditButton())
        }
    }

    private func deleteFriend(_ index: IndexSet, _ section: [String]) {
        let indexSection = friendsSection.firstIndex(of: section) ?? 0

        if friendsSection[indexSection].count <= 1 {
            friendsSection.remove(at: indexSection)
        } else {
            friendsSection[indexSection].remove(atOffsets: index)
        }
    }

    private func moveFriend(_ index: IndexSet, _ section: [String], _ value: Int) {
        let indexSection = friendsSection.firstIndex(of: section) ?? 0
        friendsSection[indexSection].move(fromOffsets: index, toOffset: value)
    }
}

extension FriendsList {
    var friendsList: some View {
        List {
            ForEach(friendsSection, id: \.self) { section in
                Section(String(section[0].first!)) {
                    ForEach(section, id: \.self) { friend in
                        NavigationLink {
                            FriendPhotosCollection(nameFriend: friend)
                        } label: {
                            FriendListCell(imageUrl: "YC",
                                     textCell: friend)
                        }
                    }
                    .onDelete { index in
                        deleteFriend(index, section)
                    }
                    .onMove { index, value in
                        moveFriend(index, section, value)
                    }
                }
            }
            .navigationTitle("Friends")
        }
        .listStyle(.inset)
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
    }
}







//
//  FriendsView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 02.09.2022.
//

import SwiftUI

// Вью для отображения экрана друзей
struct FriendsView: View {
    
    @StateObject var viewModel: FriendsViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(viewModel.filteredData) { friendSection in
                Section(header: Text(String(friendSection.key))) {
                    ForEach(friendSection.data) { friend in
                        NavigationLink {
                            FriendsProfileView(
                                viewModel: FriendsProfileViewModel(friend: friend, loader: viewModel.loader)
                            )
                        } label: {
                            FriendsRow(friend: friend)
                        }
                    }
                }
                .headerProminence(.increased)
                
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText, perform: { _ in
            viewModel.search(searchText) { }
        })
        .onSubmit(of: .search, {
            viewModel.search(searchText) { }
        })
        .onAppear(perform: {
            viewModel.fetchFriends { }
        })
        .listStyle(.insetGrouped)
    }
}


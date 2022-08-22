//
//  MainScreen.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 12.08.2022.
//

import SwiftUI

struct MainScreen: View {

    var body: some View {
        
        TabView {
            friendsTabBar
            newsTabBar
            groupsTabBar
        }
        .accentColor(.accentColor)
        
    }
}

private extension MainScreen {
    private var friendsTabBar: some View {
        FriendsList()
            .badge(2)
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Friends")
            }
    }

    private var newsTabBar: some View {
        FriendsList()
            .background(.blue)
            .tabItem {
                Image(systemName: "newspaper.fill")
                Text("News")
            }
    }

    private var groupsTabBar: some View {
        FriendsList()
            .tabItem {
                Image(systemName: "rectangle.3.group.bubble.left.fill")
                Text("Groups")
            }

    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

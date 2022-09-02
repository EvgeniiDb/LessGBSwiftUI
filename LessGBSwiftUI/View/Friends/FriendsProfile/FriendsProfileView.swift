//
//  FriendsProfileView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 02.09.2022.
//

import SwiftUI
import ASCollectionView
import Kingfisher

// Вью для отображения профиля друга
struct FriendsProfileView: View {
    
    @ObservedObject var viewModel: FriendsProfileViewModel
    
    // Флаг для отображения анимации лайка фото профиля
    @State var likesFlag: Bool = false
    
    @State var profilePhotoLikes: Int = 0
    
    private let screenWidth = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?
        .windows
        .filter({$0.isKeyWindow})
        .first?.frame.width ?? 0
    
    init(viewModel: FriendsProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                KFImage(viewModel.friend.imageUrl)
                LikeView(likeFlag: $likesFlag, likesCount: profilePhotoLikes)
                    .foregroundColor(Color.red)
            }
            .onTapGesture {
                likesFlag.toggle()
                
                profilePhotoLikes = likesFlag == true ? profilePhotoLikes + 1 : profilePhotoLikes - 1
            }
            .padding(.bottom, 16)
            
            
            Text(viewModel.friend.name)
            
            ASCollectionView(data: viewModel.storedImages) { item, _ in
                FriendsProfileRow(image: item)
            }
            .layout {
                .grid(
                    layoutMode: .fixedNumberOfColumns(3),
                    itemSpacing: 8,
                    lineSpacing: 16
                )
            }
            .onAppear {
                viewModel.fetchPhotos { }
            }
        }
        
    }
}

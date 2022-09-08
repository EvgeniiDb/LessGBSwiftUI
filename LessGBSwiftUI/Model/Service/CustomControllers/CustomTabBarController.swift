//
//  CustomTabBarController.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .white
    }
}


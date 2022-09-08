//
//  UICollectionReusableView+Extensions.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit

extension UICollectionReusableView {
    @objc static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}


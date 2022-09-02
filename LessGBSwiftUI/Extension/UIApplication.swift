//
//  UIApplication.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 02.09.2022.
//

import SwiftUI

extension UIApplication {
   func endEditing() {
       sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}


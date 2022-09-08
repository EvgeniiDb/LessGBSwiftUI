//
//  SceneDelegate.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 25.08.2022.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // Координатор авторизации приложения
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let coordinator = AppCoordinator()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        self.appCoordinator = coordinator
        coordinator.start()
    }
}

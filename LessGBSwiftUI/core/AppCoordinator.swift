//
//  AppCoordinator.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 25.08.2022.
//

import SwiftUI
import Combine

// Координатор авторизации пользователя
final class AppCoordinator {
    

    let navigationController: UINavigationController
    
    private let loginViewModel: LoginViewModel
    private var disposeBag: Set<AnyCancellable> = []
    
    init() {
        let viewModel = LoginViewModel()
        let loginView = VKLoginWebView()
        let rootViewController = UIHostingController(rootView: loginView)
        
        self.navigationController = UINavigationController(rootViewController: rootViewController)
        self.loginViewModel = viewModel
    }
    
    // Запуск приложения
    func start() {
        self.loginViewModel.$isLoggedIn
            .subscribe(on: RunLoop.main)
            .sink { [weak self] isUserLoggedIn in
                guard let self = self else { return }
                
                if isUserLoggedIn {
                    let vc = self.makeMainScreenView()
                    self.navigationController.pushViewController(vc, animated: true)
                } else {
                    self.navigationController.popToRootViewController(animated: true)
                }
            }
            .store(in: &disposeBag)
    }
    
    private func makeMainScreenView() -> UIViewController {
        let vc = UIHostingController(rootView: MainScreen())
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        let logoutButton = UIBarButtonItem(title: "Logout",
                                           style: .plain,
                                           target: self, action: #selector(logOut)
        )
        
        vc.navigationItem.leftBarButtonItem = logoutButton
        
        return vc
    }
    
    @objc
    private func logOut() {
        loginViewModel.logOut()
    }
}

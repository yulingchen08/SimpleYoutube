//
//  AppCoordinator.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit

class AppCoordinator: Coordinator {
    private weak var window: UIWindow?
    private var mainViewCoordinator: MainViewCoordinator?
    var navigation: BaseNavigationController?
    
    init(window: UIWindow?, navigation: BaseNavigationController) {
        self.window = window
        self.navigation = navigation
    }
    
    func start() {
        guard let window = window, let navigation = self.navigation else { return }
        window.rootViewController = navigation
        mainViewCoordinator = MainViewCoordinator(navigation: navigation)
        mainViewCoordinator?.start()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

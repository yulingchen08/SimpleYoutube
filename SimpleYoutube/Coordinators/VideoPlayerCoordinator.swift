//
//  VideoPlayerCoordinator.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit

class VideoPlayerCoordinator:  Coordinator {
    var navigation: BaseNavigationController?
        
    init(navigation: BaseNavigationController? = nil) {
        self.navigation = navigation
    }
    
    func start() {
        guard let navigation = navigation else { return }
        let rootViewController = VideoPlayerViewController()
        rootViewController.delegate = self
        navigation.pushViewController(rootViewController, animated: false)
    }
}

extension VideoPlayerCoordinator {
 
}

extension VideoPlayerCoordinator: VideoPlayerViewControllerDelegate {
}

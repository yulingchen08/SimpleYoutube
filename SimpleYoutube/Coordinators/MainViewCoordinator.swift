//
//  MainViewCoordinator.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit


protocol MainViewCoordinatorDelegate: AnyObject {
    
}

class MainViewCoordinator: Coordinator {
    var navigation: BaseNavigationController?
    var videoPlayerCoordinator: VideoPlayerCoordinator?

    init(navigation: BaseNavigationController? = nil) {
        self.navigation = navigation
    }
    
    func start() {
        guard let navigation = navigation else { return }
        let rootViewController = MainViewController()
        rootViewController.delegate = self
        navigation.pushViewController(rootViewController, animated: false)
    }
    
}

extension MainViewCoordinator: MainViewControllerDelegate {
    func didClickPlayVideoButton() {
        showVideoPlayerView()
    }
    
}

extension MainViewCoordinator {
    private func showVideoPlayerView() {
        guard let navigation = navigation else { return }
        videoPlayerCoordinator = VideoPlayerCoordinator(navigation: navigation)
        videoPlayerCoordinator?.start()
    }
}


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
    
    func start(object: PlaylistDomainObject.Item) {
        guard let navigation = navigation else { return }
        let viewModel = VideoPlayerViewModel(dataSource: object)
        let rootViewController = VideoPlayerViewController(viewModel: viewModel)
        rootViewController.delegate = self
        rootViewController.modalPresentationStyle = .fullScreen
        navigation.present(rootViewController, animated: false)
    }
}

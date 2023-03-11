//
//  Coordinator.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: BaseNavigationController? { get set }
}


extension Coordinator {
    func start() {}
}


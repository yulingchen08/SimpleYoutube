//
//  VideoPlayerViewController.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit

protocol VideoPlayerViewControllerDelegate: AnyObject {
    
}

class VideoPlayerViewController: UIViewController {
    
    weak var delegate: VideoPlayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//
//  MainViewController.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit
import SnapKit

protocol MainViewControllerDelegate: AnyObject {
    func didClickPlayVideoButton()
}


class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
            
    let viewLabel: UILabel = {
        let label = UILabel()
        label.text = "Main View"
        label.backgroundColor = .white
        label.textColor = .blue
        return label
    }()
    
    let playVideoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(playVideoAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


extension MainViewController {
    private func setupView() {
        
        [viewLabel, playVideoButton].forEach {
            view.addSubview($0)
        }
        
        viewLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().inset(45)
            make.height.equalTo(35)
        }
        
        playVideoButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(viewLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
             
        }
        
    }
    
    @objc
    private func playVideoAction() {
        delegate?.didClickPlayVideoButton()
    }
}

//
//  VideoTitleTableViewCell.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/14.
//

import UIKit
import SnapKit

class VideoTitleTableViewCell: UITableViewCell {
    
    static let identifier = "VideoTitleContentTableViewCell"
        
    private var videoTitle: UILabel = {
       let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        label.numberOfLines = 2
        label.text = "This is a test"
        return label
    }()
    
    private let ownerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage.init(systemName: "scribble")
        return imageView
    }()
    
    private let ownerTitleAndTime: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        label.numberOfLines = 2
        label.text = "Ryan Trahan 2023/03/13"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateFrame(object: PlaylistDomainObject.Item) {
        videoTitle.text = object.snippet.title
        ownerTitleAndTime.text = "\(object.snippet.channelTitle)   \(object.contentDetails.videoPublishedAt)"
    }
        
}

extension VideoTitleTableViewCell {
    private func setupLayout() {
        print("setupLayout")
        [videoTitle, ownerImage, ownerTitleAndTime].forEach {
            addSubview($0)
        }
        
        
        ownerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
            
        }
        
        videoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(ownerImage.snp.right).offset(15)
            make.right.equalToSuperview().inset(0)
        }
        
        ownerTitleAndTime.snp.makeConstraints { make in
            make.top.equalTo(videoTitle.snp.bottom)
            make.height.equalTo(30)
            make.left.equalTo(videoTitle.snp.left)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

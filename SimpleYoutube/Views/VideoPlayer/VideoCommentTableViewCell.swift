//
//  VideoCommentTableViewCell.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/14.
//

import UIKit
import SnapKit

class VideoCommentTableViewCell: UITableViewCell {
    
    static let identifier = "VideoCommentTableViewCell"
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Comment"
        label.textColor = .black
        label.backgroundColor = .clear
        label.sizeToFit()
        return label
    }()
    
    private var channelIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.image = UIImage.init(systemName: "scribble")
        return imageView
    }()
    
    
    private var channelComment: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "This is default comment"
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLayout() {
        
        [commentLabel, channelIcon, channelComment].forEach {
            addSubview($0)
        }
        
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
            
        }
        
        channelIcon.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(10)
            make.left.equalTo(commentLabel.snp.left)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        channelComment.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(10)
            make.left.equalTo(channelIcon.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)            
            make.height.equalTo(35)
        }
        
        func updateFrame() {
            
        }
        
    }
}


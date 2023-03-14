//
//  MainViewTableViewCell.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/12.
//

import UIKit
import SnapKit
import SDWebImage


protocol MainTableViewCellDelegate: AnyObject {
    func updateCell(channelId: String)
}

class MainViewTableViewCell: UITableViewCell {
        
    static let identifier = "MainViewTableViewCell"
    weak var delegate: MainTableViewCellDelegate?
    private let viewModel = MainViewTableViewCellViewModel()
    
    private var thumbnailImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        //imageView.image = UIImage.init(systemName: "video")
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var videoTitle: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        label.numberOfLines = 2
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
        [thumbnailImage, videoTitle, ownerImage, ownerTitleAndTime].forEach {
            addSubview($0)
        }
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        ownerImage.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
            
        }
        
        videoTitle.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(10)
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
    
    func updateFrame(object: PlaylistDomainObject.Item) {
        viewModel.getChannelIconUrl(channelId: object.snippet.channelId) { [weak self] iconUrl in
            self?.ownerImage.sd_setImage(with: iconUrl)
        }
        
        if let urlString = object.snippet.thumbnails.maxres?.url {
            thumbnailImage.sd_setImage(with: URL(string: urlString))
        }
                
        videoTitle.text = object.snippet.title
        ownerTitleAndTime.text = "\(object.snippet.channelTitle)   \(object.contentDetails.videoPublishedAt)"
    }
    
}


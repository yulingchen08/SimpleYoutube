//
//  VideoPlayerViewModel.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/14.
//

import Foundation

protocol VideoPlayerViewModelInputsType {
}

protocol VideoPlayerViewModelOutputsType: AnyObject {
}

protocol VideoPlayerViewModelType {
    var inputs: VideoPlayerViewModelInputsType { get }
    var outputs: VideoPlayerViewModelOutputsType { get }
}



class VideoPlayerViewModel: VideoPlayerViewModelInputsType, VideoPlayerViewModelOutputsType, VideoPlayerViewModelType {
    
    var inputs: VideoPlayerViewModelInputsType { return self }
    var outputs: VideoPlayerViewModelOutputsType {return self }
    
    
    
    var dataSource: PlaylistDomainObject.Item
    
    init(dataSource: PlaylistDomainObject.Item) {
        self.dataSource = dataSource
    }
    
    
}

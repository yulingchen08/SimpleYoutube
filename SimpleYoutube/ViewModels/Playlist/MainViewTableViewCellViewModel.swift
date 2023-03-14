//
//  MainViewTableViewCellViewModel.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/14.
//

import Foundation

class MainViewTableViewCellViewModel {
    let playlistRepository: PlaylistRepository = .shared
    
    func getChannelIconUrl(channelId: String, completion: @escaping (URL) -> Void) {
        playlistRepository.getChannelIconUrl(channelId: channelId) { result in
            switch result {
            case .success(let imageInfo):
                if let url = URL(string: imageInfo.url) {
                    completion(url)
                }
            case .failure(let error):
                break
                //TODO: error handling
            }
        }
    }
}

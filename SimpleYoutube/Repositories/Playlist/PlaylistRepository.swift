//
//  PlaylistRepository.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/13.
//

import Foundation

class PlaylistRepository {
    public static let shared = PlaylistRepository()
    var network: NetworkServiceProtocol = NetworkService.shared
    let dateFormatter = DateFormatter()
    
    init() { }
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func getPlayerlist(count: Int, completion: @escaping (Result<PlaylistDomainObject.Playlist, NetworkError>) -> Void) {
        network.getPlayList(count: count) { [weak self] result in
            switch result {
            case .success(let playlistDTO):
                
                var playlist = PlaylistDomainObject.Playlist(playlist: playlistDTO)
                self?.foramteDate(playList: &playlist)                           
                completion(.success(playlist))
            case .failure(let error):
                print("[PlaylistRepository] error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getChannelIconUrl(channelId: String, completion: @escaping (Result<PlaylistDomainObject.ImageInfo, NetworkError>) -> Void) {
        network.getChannel(channelId: channelId) { [weak self] result in
            switch result {
            case .success(let channel):
                guard let channelItem = channel.items.first,
                      let info = channelItem.snippet.thumbnails.high else {
                    completion(.failure(.reponseNil))
                    return
                }
                
                let imageInfo = PlaylistDomainObject.ImageInfo(height: info.height, width: info.width, url: info.url)
                completion(.success(imageInfo))
            case .failure(let error):
                completion(.failure(error))
                break
            }
            
        }
    }
        
}

extension PlaylistRepository {
    private func foramteDate(playList: inout PlaylistDomainObject.Playlist) {
            for i in 0..<playList.items.count {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                if let date = dateFormatter.date(from: playList.items[i].contentDetails.videoPublishedAt) {
                    dateFormatter.dateFormat = "MMM d, yyyy h:mm"
                    playList.items[i].contentDetails.videoPublishedAt = dateFormatter.string(from: date)
                }
            }
    }
}

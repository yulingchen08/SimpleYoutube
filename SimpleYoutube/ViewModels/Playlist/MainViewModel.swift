//
//  MainViewModel.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/13.
//

import Foundation

protocol MainViewModelModelInputsType {
    func scrollToBottom()
    func loadData()
}

protocol MainViewModelModelOutputsType: AnyObject {
    var presentPlaylistCell: (() -> Void) { get set }
}

protocol MainViewModelType {
    var inputs: MainViewModelModelInputsType { get }
    var outputs: MainViewModelModelOutputsType { get }
}

class MainViewModel: MainViewModelType,
                     MainViewModelModelInputsType,
                     MainViewModelModelOutputsType {
    
    var playlistRepository: PlaylistRepository = .shared
    var inputs: MainViewModelModelInputsType { return self }
    var outputs: MainViewModelModelOutputsType { return self }
    var dataSource:  PlaylistDomainObject.Playlist = .init()
    
    //MARK: - Outputs:
    var presentPlaylistCell: (() -> Void) = {}
    
    init() {}
    init(playlistRepository: PlaylistRepository = PlaylistRepository()) {
        self.playlistRepository = playlistRepository
    }
    
    //MARK: - Inputs
    func scrollToBottom() {
        updatePlaylist(count: 20)
    }
    
    func loadData() {
        updatePlaylist(count: 30)
    }
    
}

extension MainViewModel {
    private func updatePlaylist(count: Int) {
        playlistRepository.getPlayerlist(count: count) { [weak self] result in
            switch result {
            case .success(let playlist):
                self?.dataSource.items.append(contentsOf: playlist.items)
                self?.dataSource.nextPageToken = playlist.nextPageToken
                self?.dataSource.prevPageToken = playlist.prevPageToken
                self?.outputs.presentPlaylistCell()
            case .failure(let error):
                print("[MainViewModel] getPlayerlist error: \(error)")
            }
        }
    }
}


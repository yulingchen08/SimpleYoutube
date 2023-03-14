//
//  PlaylistDomainObject.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/13.
//

import Foundation

struct PlaylistDomainObject {
    struct Playlist: Codable {
        var items: [Item]
        var prevPageToken: String?
        var nextPageToken: String?
        
        init(playlist: PlaylistDTO.Playlist) {
            let items = playlist.items.flatMap { Item(item: $0) }
            self.items = items
            self.prevPageToken = playlist.prevPageToken
            self.nextPageToken = playlist.nextPageToken
        }
        
        init() {
            self.items = []
        }
    }

    struct Item: Codable {
        var contentDetails: Content
        let snippet: Snippet
        
        init(item: PlaylistDTO.Item) {
            self.contentDetails = Content(content: item.contentDetails)
            self.snippet = Snippet(snippet: item.snippet)
        }
    }

    struct Content: Codable {
        let videoId: String
        var videoPublishedAt: String
        
        init(content: PlaylistDTO.Content) {
            self.videoId = content.videoId
            self.videoPublishedAt = content.videoPublishedAt
        }               
    }

    struct Snippet: Codable {
        let channelTitle: String
        let channelId: String
        let description: String
        let thumbnails: Thumbnails
        let title: String
        
        init(snippet: PlaylistDTO.Snippet) {
            self.channelTitle = snippet.channelTitle
            self.channelId = snippet.channelId
            self.description = snippet.description
            self.thumbnails = Thumbnails(thumbnails: snippet.thumbnails)
            self.title = snippet.title
        }
    }

    struct Thumbnails: Codable {
        let maxres: ImageInfo?
        
        init(thumbnails: PlaylistDTO.Thumbnails) {
            if let maxres = thumbnails.maxres {
                self.maxres = ImageInfo(imageInfo: maxres)
            } else {
                self.maxres = nil
            }
            
        }
    }

    struct ImageInfo: Codable {
        let height: Int
        let width: Int
        let url: String
        
        init(imageInfo: PlaylistDTO.ImageInfo) {
            self.height = imageInfo.height
            self.width = imageInfo.width
            self.url = imageInfo.url
        }
        
        init(height: Int, width: Int, url: String) {
            self.height = height
            self.width = width
            self.url = url
        }
    }
    
    struct Channel: Codable {
        let thumbnails: ImageInfo?
    }
}

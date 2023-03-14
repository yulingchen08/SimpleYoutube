//
//  PlaylistDTO.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/12.
//

import Foundation


struct PlaylistDTO {
    struct Playlist: Codable {
        let items: [Item]
        let prevPageToken: String?
        let nextPageToken: String?
    }

    struct Item: Codable {
        let contentDetails: Content
        let snippet: Snippet
    }

    struct Content: Codable {
        let videoId: String
        let videoPublishedAt: String
    }

    struct Snippet: Codable {
        let channelTitle: String
        let channelId: String
        let description: String
        let thumbnails: Thumbnails
        let title: String
    }

    struct Thumbnails: Codable {
        let maxres: ImageInfo?
    }

    struct ImageInfo: Codable {
        let height: Int
        let width: Int
        let url: String
    }
}

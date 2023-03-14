//
//  ChannelDTO.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/14.
//

import Foundation


struct ChannelDTO {
    struct Channel: Codable {
        let items: [Items]
    }
    
    struct Items: Codable {
        let snippet: Snippet
    }
    
    
    struct Snippet: Codable {
        let thumbnails: Thumbnails
        let title: String
    }
    
    struct Thumbnails: Codable {
        let high: ImageInfo?
    }
    
    struct ImageInfo: Codable {
        let height: Int
        let width: Int
        let url: String
    }
    
}


//
//  NetworkService.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/12.
//

import Foundation


protocol NetworkServiceProtocol: AnyObject {
    func getPlayList(count: Int, completion: @escaping (Result<PlaylistDTO.Playlist, NetworkError>) -> Void)
    func getChannel(channelId: String, completion: @escaping (Result<ChannelDTO.Channel, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case httpError
    case urlError
    case reponseNil
    case decoderError
}

struct ApiConstants {
    static let apiKey = "AIzaSyCc8TsFsAAzAxSSUyEMVuRrxlckGQ5KKgc"
    static let playlistURL = "https://www.googleapis.com/youtube/v3/playlistItems"
    //static let videosURL = "https://www.googleapis.com/youtube/v3/videos"
    static let playlistId = "PLjp0AEEJ0-fFLaVhbbaopheKg90xaocFY"
    static let channelURL = "https://youtube.googleapis.com/youtube/v3/channels"
}

class NetworkService: NetworkServiceProtocol {
    public static let shared = NetworkService()
    
    /*
    func getVideos() {
      
        let url = URL.init(string: "https://www.googleapis.com/youtube/v3/videos?id=jeqH4eMGjhY&key=AIzaSyDQiBZ3NI61iI5LEui2JpUlXnrOFYLQjL0&part=snippet")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
              //  completion(.failure(.httpError))
                print("getVideo error")
                return
            }
            
            print("getVideo success")
            do {
                let printJson = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                print("videos: ", printJson)
                //let results = try JSONDecoder().decode(YoutubeVideosStruck.self, from: data)
                //completion(.success(results.items[0]))
            }
            catch {
                //completion(.failure(YoutubeCatchDataError.getVideos))
            }
            
            //completion(.success(true))
        }.resume()
        
        
    }
    
   
    */
    func getPlayList(count: Int, completion: @escaping (Result<PlaylistDTO.Playlist, NetworkError>) -> Void) {

        let url = URL.init(string: "\(ApiConstants.playlistURL)?part=snippet,contentDetails,status&playlistId=\(ApiConstants.playlistId)&key=\(ApiConstants.apiKey)&maxResults=\(count)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.httpError))
                print("getPlayList error")
                return
            }
            
            print("getPlayList success")
            do {
                let printJson = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                print("Playlist: ", printJson)
                let playlist = try JSONDecoder().decode(PlaylistDTO.Playlist.self, from: data!)
                print("PlaylistDTO", playlist)
                completion(.success(playlist))
            }
            catch {
                completion(.failure(.decoderError))
            }
                        
        }.resume()
        
    }
   
    func getChannel(channelId: String, completion: @escaping (Result<ChannelDTO.Channel, NetworkError>) -> Void) {
        let url = URL.init(string: "\(ApiConstants.channelURL)?part=snippet,contentDetails,statistics,brandingSettings&id=\(channelId)&key=\(ApiConstants.apiKey)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.httpError))
                print("getChannel error")
                return
            }
            
            print("getChannel success")
            do {
                let printJson = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                print("channel: ", printJson)
                let channel = try JSONDecoder().decode(ChannelDTO.Channel.self, from: data!)
                print("ChannelDTO", channel)
                completion(.success(channel))
            }
            catch {
                //completion(.failure(YoutubeCatchDataError.getVideos))
            }
            
            //completion(.success(true))
        }.resume()
        
        
    }
    
}




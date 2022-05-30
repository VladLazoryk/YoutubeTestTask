//
//  APICaller.swift
//  YoutubeApi
//
//  Created by vlad on 5/25/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//


import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let baseUrl = "https://www.googleapis.com/youtube/v3/"
    private let apiKey = "AIzaSyBFGiA-Vd6WBrxxC7AuUimHJyf7BJDjEao"
    
    func getChannelData(id: String, completion: @escaping (_ data: ChannelModel?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        AF.request(baseUrl + "channels", method: .get, parameters: ["part": "statistics, brandingSettings, contentDetails, snippet", "id": id, "key": apiKey], encoding: URLEncoding.default, headers: nil).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(try? JSONDecoder().decode(ChannelModel.self, from: data))
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getPlaylistData(id: String, completion: @escaping (_ data: PlaylistModel?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        AF.request(baseUrl + "playlists", method: .get, parameters: ["part": "contentDetails, snippet", "id": id, "key": apiKey], encoding: URLEncoding.default, headers: nil).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(try? JSONDecoder().decode(PlaylistModel.self, from: data))
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getPlaylistVideosData(id: String, completion: @escaping (_ data: PlaylistVideoItemModel?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        AF.request(baseUrl + "playlistItems", method: .get, parameters: ["part": "contentDetails", "playlistId": id, "key": apiKey], encoding: URLEncoding.default, headers: nil).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(try? JSONDecoder().decode(PlaylistVideoItemModel.self, from: data))
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getVideoData(id: String, completion: @escaping (_ data: VideoModel?) -> Void, failure: @escaping (_ error: Error) -> Void) {
        AF.request(baseUrl + "videos", method: .get, parameters: ["part": "statistics, snippet", "id": id, "key": apiKey], encoding: URLEncoding.default, headers: nil).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(try? JSONDecoder().decode(VideoModel.self, from: data))
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}

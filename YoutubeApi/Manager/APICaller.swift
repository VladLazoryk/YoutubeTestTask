//
//  APICaller.swift
//  YoutubeApi
//
//  Created by vlad on 5/29/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
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



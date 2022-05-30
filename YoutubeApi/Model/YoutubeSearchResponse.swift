//
//  YoutubeSearchResponse.swift
//  YoutubeApi
//
//  Created by vlad on 5/26/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//


import Foundation



struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

//
//  PlayListColumns.swift
//  YoutubeApi
//
//  Created by vlad on 5/26/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import Foundation

enum PlayListColumns {
    case chanels(data: [ChannelItemModel])
    case firstPlaylist(data: [PlaylistItemModel])
    case secondPlaylist(data: [PlaylistItemModel])
    
    var orderNumber: Int {
        switch self {
        case .chanels:
           return 0
        case .firstPlaylist:
           return 1
        case .secondPlaylist:
           return 2
        }
    }
}

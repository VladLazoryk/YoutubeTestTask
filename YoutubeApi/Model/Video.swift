
import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}


struct ChannelModel: Decodable {
    var items: [ChannelItemModel]
}

struct ChannelItemModel: Decodable {
    var statistics: ChannelStatisticModel
    var snippet: ChannelSnippetModel
    var brandingSettings: ChannelBrandingSettingsModel
    var contentDetails: ChannelDetailsModel
}

struct ChannelBrandingSettingsModel: Decodable {
    var image: ChannelBannerModel
}

struct ChannelBannerModel: Decodable {
    var bannerExternalUrl: String
    var imageData: Data?
}

struct ChannelDetailsModel: Decodable {
    var relatedPlaylists: ChannelPlaylistRelatedModel
}

struct ChannelPlaylistRelatedModel: Decodable {
    var uploads: String
}

struct ChannelSnippetModel: Decodable {
    var title: String
}

struct ChannelStatisticModel: Decodable {
    var subscriberCount: String
}

struct CollectionViewCellModel {
    var image: UIImage
    var name: String
    var viewsCount: Int
}


struct PlaylistVideoItemModel: Decodable {
    var items: [PlaylistVideoItemDetailsModel]
}

struct PlaylistVideoItemDetailsModel: Decodable {
    var contentDetails: PlaylistContentDetails
}

struct PlaylistContentDetails: Decodable {
    var videoId: String
}

struct PlaylistModel: Decodable {
    var items: [PlaylistItemModel]
}

struct PlaylistItemModel: Decodable {
    var id: String
    var snippet: PlaylistSnippetModel
    var imageData: Data?
    var playlistVideoData: PlaylistVideoItemModel?
}

struct PlaylistSnippetModel: Decodable {
    var thumbnails: PlaylistTrumbnailsModel
    var title: String
}

struct PlaylistTrumbnailsModel: Decodable {
    var medium: PlaylistImageModel
}

struct PlaylistImageModel: Decodable {
    var url: String
}

struct VideoModel: Decodable {
    var items: [VideoItemModel]
}

struct VideoItemModel: Decodable {
    var snippet: VideoSnippetModel
    var statistics: VideoStatisticsModel
}

struct VideoStatisticsModel: Decodable {
    var viewCount: String
}

struct VideoSnippetModel: Decodable {
    var title: String
}



enum MainTableViewSection {
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



import UIKit

protocol VideoModelDelegate: class {

    func dataReady()
}

class VideoModel : NSObject {
    let apiKey = "AIzaSyCKx6f39vFN84qnGM6x2s_tyPzLwoN2cnA"
    var videos = [Video]()
    var nextPageToken : String? = nil
    weak var delegate: VideoModelDelegate?
    
    
    private func parseSearchJSON(video: Any) {
        let videoInfo = video as! [String: AnyObject]
        let searchId = videoInfo["id"] as! [String: AnyObject]
        let videoId = searchId["videoId"] as! String
        let snippet = videoInfo["snippet"] as! [String: AnyObject]
        let videoTitle = snippet["title"] as! String
        let channelTitle = snippet["channelTitle"] as! String
        let thumbnails = snippet["thumbnails"] as! [String: AnyObject]
        let defaultSizeThumbnail = thumbnails["default"] as! [String: AnyObject]
        let thumbnailURL = defaultSizeThumbnail["url"] as! String
        videos.append(Video(title: videoTitle, thumbnailURL: thumbnailURL, channel: channelTitle, videoId: videoId))
    }
    
    //Get video title, thumbnail, and channel name
    private func parseTrendingJSON(video: Any) {
        let videoInfo = video as! [String: AnyObject]
        let videoId = videoInfo["id"] as! String
        let snippet = videoInfo["snippet"] as! [String: AnyObject]
        let videoTitle = snippet["title"] as! String
        let channelTitle = snippet["channelTitle"] as! String
        let thumbnails = snippet["thumbnails"] as! [String: AnyObject]
        let defaultSizeThumbnail = thumbnails["default"] as! [String: AnyObject]
        let thumbnailURL = defaultSizeThumbnail["url"] as! String
        videos.append(Video(title: videoTitle, thumbnailURL: thumbnailURL, channel: channelTitle, videoId: videoId))
    }
}

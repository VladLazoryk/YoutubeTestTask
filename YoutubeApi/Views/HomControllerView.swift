import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateData()
}

class ViewControllerViewModel {
    private let channelsId = ["UC2D6eRvCeMtcF5OGHf1-trw",
                              "UCWJULrY4qhbj0pqnNOrYETg",
                              "UCCmIOD1w5zjCK6kUp8vv1jw",
                              "UCiyiEAeWUuuPj6tt_jePALQ"]
    
    private let playlistsId = ["PLmTuDg46zmKCl2WZDk9YkEAnS9OJg9ac",
                               "PLYJ8AuC0Q2e_XLb97Z86KsLCRv-eSyOvj",
                               "PLOWNkHTFkkpMP1vtgEdBB7J8OPVMxHfmh",
                               "PLOWNkHTFkkpMP1vtgEdBB7J8OPVMxHfmh",
                               "PLOWNkHTFkkpMP1vtgEdBB7J8OPVMxHfmh",
                               "PLmTuDg46zmKCkZeoJjZlLem1l6IhKhOAF",
                               "PLmTuDg46zmKCl2WZDk9YkEAnS9OJg9ac",
                               "PLYJ8AuC0Q2e_XLb97Z86KsLCRv-eSyOvj",
                               "PLmTuDg46zmKCkZeoJjZlLem1l6IhKhOAF"]
    
    private var channelsData: [ChannelItemModel] = []
    private var playlistsData: [PlaylistItemModel] = []
    
    private var dataSource: [MainTableViewSection] = []
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func getDataSource() -> [MainTableViewSection] {
        dataSource.sorted { $0.orderNumber < $1.orderNumber }
    }
    
    func loadChannelsData() {
        let group = DispatchGroup()
        channelsId.forEach {
            loadChannelsData(id: $0, group: group)
        }
        group.notify(queue: .main) {
            self.dataSource.append(.chanels(data: self.channelsData))
            self.delegate?.updateData()
        }
    }
    
    func loadPlaylistsData() {
        let group = DispatchGroup()
        playlistsId.forEach {
            loadPlaylistsData(id: $0, group: group)
        }
        group.notify(queue: .main) {
            self.dataSource.append(.firstPlaylist(data: self.playlistsData))
            self.dataSource.append(.secondPlaylist(data: self.playlistsData))
            self.delegate?.updateData()
        }
    }
    
    // MARK: - Private methods
    private func loadChannelsData(id: String, group: DispatchGroup) {
        group.enter()
        DispatchQueue.main.async {
            NetworkManager.shared.getChannelData(id: id) { data in
                if let data = data, var firstItem = data.items.first, let imageURL = URL(string: firstItem.brandingSettings.image.bannerExternalUrl) {
                    let imageData = try? Data(contentsOf: imageURL)
                    firstItem.brandingSettings.image.imageData = imageData
                    self.channelsData.append(firstItem)
                }
                group.leave()
            }; failure { error in
                group.leave()
            }
        }
    }
    
    private func loadPlaylistsData(id: String, group: DispatchGroup) {
        group.enter()
        DispatchQueue.main.async {
            NetworkManager.shared.getPlaylistData(id: id) { data in
                guard let data = data, var firstItem = data.items.first, let imageURL = URL(string: firstItem.snippet.thumbnails.medium.url) else {
                    group.leave()
                    return
                }
                let imageData = try? Data(contentsOf: imageURL)
                firstItem.id = id
                firstItem.imageData = imageData
                
                NetworkManager.shared.getPlaylistVideosData(id: id) { data in
                    firstItem.playlistVideoData = data
                    self.playlistsData.append(firstItem)
                    group.leave()
                } ;failure { error in
                    self.playlistsData.append(firstItem)
                    group.leave()
                }
            } ; failure { error in
                group.leave()
            }
        }
    }
}

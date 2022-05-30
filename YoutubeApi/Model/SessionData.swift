//
//  SessionData.swift
//  YoutubeApi
//
//  Created by vlad on 5/26/22.
//  Copyright © 2022 Vlad Lazoryk. All rights reserved.
//

import UIKit


class UpNextWrapper {
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(songFinishedHandler), name: .songFinished, object: nil)
    }
    
    static let shared = UpNextWrapper()
    
    private var upNextSongs: [Song] = []
    private var currentlyPlayingIndex = -1
    
    func getUpNextSongs() -> [Song] {
        return upNextSongs
    }
    
    func setUpNextSongs(songs: [Song]) {
        upNextSongs = songs
    }
    
    func getCurrentlyPlayingIndex() -> Int {
        return currentlyPlayingIndex
    }
    
    func setCurrentlyPlayingIndex(index: Int) {
        if index >= upNextSongs.count { return }
        self.currentlyPlayingIndex = index
        NotificationCenter.default.post(name: .currentlyPlayingIndexChanged, object: nil)
    }
    
    func getCurrentSong() -> Song {
        return upNextSongs[currentlyPlayingIndex]
    }
    
    func incrementCurrentIndex() {
        let nextIndex = currentlyPlayingIndex + 1
        if nextIndex == upNextSongs.count {
            setCurrentlyPlayingIndex(index: upNextSongs.count + 1)
        } else {
            setCurrentlyPlayingIndex(index: nextIndex)
        }
    }
    
    func decrementCurrentIndex() {
        let previousIndex = currentlyPlayingIndex - 1
        if previousIndex < 0 {
            setCurrentlyPlayingIndex(index: 0)
        } else {
            setCurrentlyPlayingIndex(index: previousIndex)
        }
    }
    
    @objc func songFinishedHandler() {
        incrementCurrentIndex()
    }
    
}

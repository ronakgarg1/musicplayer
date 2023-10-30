//
//  SongDetailViewModel.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation

struct SongDetailViewModel {
    var url: String
    
    let songs: [String]
    
    var songURL: URL {
        URL(string: url)!
    }
    
    var nextSong: String? {
        guard let index = songs.firstIndex(of: url) else {
            return nil
        }
        let index1 = songs.index(after: index)
        guard index1 < songs.count else {
            return nil
        }
        return songs[index1]
    }
    
    var prevSong: String? {
        guard let index = songs.firstIndex(of: url) else {
            return nil
        }
        let index1 = songs.index(before: index)
        guard index1 >= 0 else {
            return nil
        }
        return songs[index1]
    }
}

//
//  SongListViewModel.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation

struct SongListViewModel {
    
    let networkService: NetworkService
    
    var array: (([SongModel]) -> ())?
    
    func getSongList() {
        networkService.getSongList { list in
            self.array?(list.genres)
        }
    }
}

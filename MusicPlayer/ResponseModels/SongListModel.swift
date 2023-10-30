//
//  SongListModel.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation

struct SongModel: Decodable {
    let name: String
    let id: String
    
}

struct SongListModel: Decodable {
    let genres: [SongModel]
}

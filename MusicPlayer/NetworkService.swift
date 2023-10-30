//
//  NetworkService.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation
import Alamofire

final class NetworkService {
    
    let session: Session = .default
    
    func getSongList(completion: @escaping (SongListModel) -> ()) {
        session.request("https://musicbrainz.org/ws/2/genre/all",
                        headers: ["Accept": "application/json",
                                  "User-Agent": "MusicPlayer/1.2.0 ( https://www.google.com )"])
        .response { response in
            guard let data = response.data else {
                return
            }
            let jsonDecoder = JSONDecoder()
            let model = try! jsonDecoder.decode(SongListModel.self, from: data)
            completion(model)
        }
    }
}

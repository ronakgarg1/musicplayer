//
//  SongListViewController.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation
import UIKit
import SnapKit

final class SongListViewController: UIViewController {
    
    var viewModel: SongListViewModel
    
    let tableView = UITableView()
    
    var array = [SongModel]()
    var songs: [String] = ["http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3",
                                        "http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3",
                                        "http://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/theme_01.mp3"]
    
    init(viewModel: SongListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "SongTableViewCell")
        setupConstraints()
        viewModel.array = { [weak self] list in
            DispatchQueue.main.async {
                self?.array = Array(list.prefix(through: 2))
                
                self?.tableView.reloadData()
            }
        }
        viewModel.getSongList()
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension SongListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell else {
            return UITableViewCell()
        }
        cell.songId.text = array[indexPath.row].id
        cell.songName.text = array[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = SongDetailViewModel(url: songs[indexPath.row], songs: songs)
        let detailVC = SongDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

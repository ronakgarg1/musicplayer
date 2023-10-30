//
//  SongTableViewCell.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation
import UIKit
import SnapKit

final class SongTableViewCell: UITableViewCell {
    
    let songName = UILabel()
    let songId = UILabel()
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        contentView.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(songId)
        containerView.addSubview(songName)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        songName.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(10)
        }
        songId.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(10)
            make.top.equalTo(songName.snp.bottom).offset(10)
        }
    }
}

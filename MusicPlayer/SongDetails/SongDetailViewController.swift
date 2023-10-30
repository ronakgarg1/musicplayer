//
//  SongDetailViewController.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import Foundation
import UIKit
import SnapKit
import AVFoundation

final class SongDetailViewController: UIViewController {
    var viewModel: SongDetailViewModel
    let label = UILabel()
    let avPlayer = AVPlayer()
    let nextButton = UIButton()
    let prevButton = UIButton()
    let pausePlayButton = UIButton()
    let stackView = UIStackView()
    
    var isPlaying = false
    
    init(viewModel: SongDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(stackView)
        stackView.addArrangedSubview(prevButton)
        stackView.addArrangedSubview(pausePlayButton)
        stackView.addArrangedSubview(nextButton)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        stackView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        prevButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        pausePlayButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        prevButton.setImage(UIImage(systemName: "arrowtriangle.left"), for: .normal)
        nextButton.setImage(UIImage(systemName: "arrowtriangle.right"), for: .normal)
        setuppausePlay()
        setupPrevNextButton()
        prevButton.isHidden = viewModel.prevSong == nil
        nextButton.isHidden = viewModel.nextSong == nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPlayer()
    }
    
    func setupPlayer() {
        avPlayer.replaceCurrentItem(with: AVPlayerItem(url: viewModel.songURL))
        avPlayer.play()
        isPlaying = true
        pausePlayButton.setImage(UIImage(systemName: !isPlaying ? "playpause.fill" : "playpause"), for: .normal)
    }
    
    func setuppausePlay() {
        pausePlayButton.addTarget(self, action: #selector(pausePlay), for: .touchUpInside)
    }
    
    @objc func pausePlay() {
        isPlaying ? avPlayer.pause() : avPlayer.play()
        pausePlayButton.setImage(UIImage(systemName: isPlaying ? "playpause.fill" : "playpause"), for: .normal)
        isPlaying.toggle()
    }
    
    func setupPrevNextButton() {
        nextButton.addTarget(self, action: #selector(playNext), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(playPrevious), for: .touchUpInside)
    }
    
    @objc func playNext() {
        guard let song = viewModel.nextSong else {
            return
        }
        viewModel.url = song
        setupPlayer()
        pausePlayButton.setImage(UIImage(systemName: !isPlaying ? "playpause.fill" : "playpause"), for: .normal)
        
        label.text = "\(viewModel.songs.firstIndex(of: song) ?? 0)"
        prevButton.isHidden = viewModel.prevSong == nil
        nextButton.isHidden = viewModel.nextSong == nil
    }
    @objc func playPrevious() {
        guard let song = viewModel.prevSong else {
            return
        }
        viewModel.url = song
        setupPlayer()
        pausePlayButton.setImage(UIImage(systemName: !isPlaying ? "playpause.fill" : "playpause"), for: .normal)
        label.text = "\(viewModel.songs.firstIndex(of: song) ?? 0)"
        prevButton.isHidden = viewModel.prevSong == nil
        nextButton.isHidden = viewModel.nextSong == nil
    }
}

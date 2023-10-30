//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Ronak Garg on 30/10/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func goToPlayer(_ sender: Any) {
        let service = NetworkService()

        let vm = SongListViewModel(networkService: service)
        let vc = SongListViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}


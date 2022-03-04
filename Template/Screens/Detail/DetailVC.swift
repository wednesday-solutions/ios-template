//
//  DetailVC.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit
import AVKit

class DetailVC: UIViewController {

    var playerVC = AVPlayerViewController()
    
    var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    var lblSongName: UILabel = {
        let songName = UILabel()
        songName.font = UIFont.systemFont(ofSize: 18)
        songName.translatesAutoresizingMaskIntoConstraints = false
        
        return songName
    }()
    
    var lblArtistName: UILabel = {
        let artistName = UILabel()
        artistName.font = UIFont.systemFont(ofSize: 18)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        
        return artistName
    }()
    
    var lblAlbumName: UILabel = {
        let albumName = UILabel()
        albumName.font = UIFont.systemFont(ofSize: 18)
        albumName.translatesAutoresizingMaskIntoConstraints = false
        
        return albumName
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white

        view.addSubview(playerView)
        view.addSubview(lblSongName)
        view.addSubview(lblArtistName)
        view.addSubview(lblAlbumName)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: margins.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            
            lblSongName.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            lblSongName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblSongName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lblArtistName.topAnchor.constraint(equalTo: lblSongName.bottomAnchor, constant: 20),
            lblArtistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblArtistName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lblAlbumName.topAnchor.constraint(equalTo: lblArtistName.bottomAnchor, constant: 20),
            lblAlbumName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblAlbumName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        lblSongName.text = "Song: Perfect"
        lblArtistName.text = "Artist: Ed Sheeran"
        lblAlbumName.text = "Album: Divide"
        
        
        
        let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        playerVC.player = AVPlayer(url: videoURL!)
        playerVC.view.frame = playerView.frame
        playerView.addSubview(playerVC.view)
        
        
        
        
    }
    
}

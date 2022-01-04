//
//  DetailViewController.swift
//  Template
//
//  Created by Rameez Khan on 16/10/21.
//

import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    let song: ItunesResult
    let playerViewController = AVPlayerViewController()
    
    let playerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    init(with song: ItunesResult) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        guard let previewURLString = song.previewURL else { return }
        guard let previewURL = URL(string: previewURLString) else { return }
        let audioPlayer = AVPlayer(url: previewURL)
        playerViewController.player = audioPlayer
        playerViewController.view.frame = playerView.frame
        playerView.addSubview(playerViewController.view)
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: 300))
        
        guard let previewImageURLString = song.artworkUrl100 else { return }
        guard let previewImageURL = URL(string: previewImageURLString) else { return }
        do {
            let imageData = try Data(contentsOf: previewImageURL)
            imageView.image = UIImage(data: imageData)
            playerViewController.contentOverlayView?.backgroundColor = .yellow
            playerViewController.contentOverlayView?.addSubview(imageView)
        } catch let error {
            print("Error is \(error.localizedDescription)")
        }
        
    }
}

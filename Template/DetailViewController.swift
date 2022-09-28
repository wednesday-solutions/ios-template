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
    
    //MARK: - Views
    private let playerImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let playerTracker: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let previousTrackButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.previousTrack.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextTrackButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.nextTrack.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playTrackButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.play.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playerControlsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        
        NSLayoutConstraint.activate([
            previousTrackButton.heightAnchor.constraint(equalToConstant: 24),
            previousTrackButton.widthAnchor.constraint(equalToConstant: 24),
            nextTrackButton.heightAnchor.constraint(equalToConstant: 24),
            nextTrackButton.widthAnchor.constraint(equalToConstant: 24),
            playTrackButton.heightAnchor.constraint(equalToConstant: 60),
            playTrackButton.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        stackView.addArrangedSubview(previousTrackButton)
        stackView.addArrangedSubview(playTrackButton)
        stackView.addArrangedSubview(nextTrackButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        setupPlayerImageView()
        setupPlayerControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupPlayerData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Subview setup
    private func setupPlayerImageView() {
        view.addSubview(playerImageContainerView)
        NSLayoutConstraint.activate([
            playerImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            playerImageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            playerImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55)
        ])
        
        playerImageContainerView.addSubview(playerImageView)
        NSLayoutConstraint.activate([
            playerImageView.leftAnchor.constraint(equalTo: playerImageContainerView.leftAnchor, constant: 32),
            playerImageView.topAnchor.constraint(equalTo: playerImageContainerView.topAnchor, constant: 16),
            playerImageView.rightAnchor.constraint(equalTo: playerImageContainerView.rightAnchor, constant: -32),
            playerImageView.bottomAnchor.constraint(equalTo: playerImageContainerView.bottomAnchor, constant: -32),
        ])
    }
    
    private func setupPlayerControl() {
        view.addSubview(playerControlsView)
        NSLayoutConstraint.activate([
            playerControlsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            playerControlsView.heightAnchor.constraint(equalToConstant: 60),
            playerControlsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            playerControlsView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupPlayerData() {
        guard let previewImageURLString = song.artworkUrl60 else { return }
        guard let previewImageURL = URL(string: previewImageURLString) else { return }
        do {
            let imageData = try Data(contentsOf: previewImageURL)
            playerImageView.image = UIImage(data: imageData)
            playerViewController.contentOverlayView?.backgroundColor = .yellow
        } catch let error {
            print("Error is \(error.localizedDescription)")
        }
    }
    
    private func setupView() {
        navigationItem.title = song.trackName
        view.backgroundColor = Asset.Colors.appBackground.color
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
    }
}

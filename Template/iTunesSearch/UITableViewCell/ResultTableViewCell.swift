//
//  ResultTableViewCell.swift
//  Template
//
//  Created by Rameez Khan on 25/10/21.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = FontFamily.Roboto.regular.font(size: 12.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = "song-title"
        lbl.accessibilityIdentifier = "song-title"
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = FontFamily.Roboto.regular.font(size: 10.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = "song-description"
        lbl.accessibilityIdentifier = "song-description"
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(resultImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            // ImageView constraints
            resultImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            resultImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            resultImageView.heightAnchor.constraint(equalToConstant: 30.0),
            resultImageView.widthAnchor.constraint(equalToConstant: 30.0),
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            // Description label constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor, constant: 8.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0)
        ])
    }
    
    func setupSong(with ituneResult: ItunesResult, cache: NSCache<NSString, UIImage>) {
        titleLabel.text = ituneResult.trackName
        descriptionLabel.text = ituneResult.artistName
        if let imageUrl = ituneResult.artworkUrl30, let url = URL(string: imageUrl) {
            DispatchQueue.global(qos: .default).async { [weak self] in
                do {
                    guard let cachedImage = cache.object(forKey: imageUrl as NSString) else {
                        guard let image = UIImage(data: try Data(contentsOf: url)) else { return }
                        cache.setObject(image, forKey: imageUrl as NSString)
                        DispatchQueue.main.async {
                            self?.resultImageView.image = image
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self?.resultImageView.image = cachedImage
                    }
                } catch let error {
                    print("error is \(error)")
                }
            }
        }
    }
}

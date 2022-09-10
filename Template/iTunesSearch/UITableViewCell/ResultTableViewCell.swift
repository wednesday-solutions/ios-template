//
//  ResultTableViewCell.swift
//  Template
//
//  Created by Rameez Khan on 25/10/21.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier = "ResultTableViewCellIndetifier"
    static let cellHeight: CGFloat = 83 // 75 resultImage height + top & bottom padding of 4
    //MARK: - Views
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = FontFamily.Roboto.medium.font(size: 18.0)
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = "song-title"
        lbl.accessibilityIdentifier = "song-title"
        lbl.textColor = .white
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textAlignment = .left
        lbl.font = FontFamily.Roboto.regular.font(size: 18.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = "song-description"
        lbl.accessibilityIdentifier = "song-description"
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var resultTitleAndDescriptionView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Asset.Colors.appBackground.color
        addResultImageView()
        addResultTitleAndDescriptionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addResultImageView() {
        addSubview(resultImageView)
        NSLayoutConstraint.activate([
            // ImageView constraints
            resultImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            resultImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultImageView.heightAnchor.constraint(equalToConstant: 75.0),
            resultImageView.widthAnchor.constraint(equalToConstant: 75.0)
        ])
    }
    
    private func addResultTitleAndDescriptionView() {
        addSubview(resultTitleAndDescriptionView)
        NSLayoutConstraint.activate([
            resultTitleAndDescriptionView.leadingAnchor.constraint(equalTo: resultImageView.trailingAnchor,constant: 8),
            resultTitleAndDescriptionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultTitleAndDescriptionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -4)
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

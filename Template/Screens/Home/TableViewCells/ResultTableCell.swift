//
//  ResultTableCell.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class ResultTableCell: UITableViewCell {
    
    var albumIV: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var lblTitle: UILabel = {
        let titleLable = UILabel()
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLable
    }()
    
    var lblSubTitle: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 10)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return subTitleLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(albumIV)
        self.addSubview(lblTitle)
        self.addSubview(lblSubTitle)
        
        NSLayoutConstraint.activate([
            albumIV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumIV.heightAnchor.constraint(equalToConstant: 30.0),
            albumIV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            albumIV.widthAnchor.constraint(equalToConstant: 30.0),

            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            lblTitle.leadingAnchor.constraint(equalTo: albumIV.trailingAnchor, constant: 10),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblSubTitle.leadingAnchor.constraint(equalTo: albumIV.trailingAnchor, constant: 10),
            lblSubTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lblSubTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(index: Int) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            do {
                guard let image = UIImage(data: try Data(contentsOf: URL(string: "https://www.rollingstone.com/wp-content/uploads/2019/12/TaylorSwiftTimIngham.jpg")!)) else { return }
                
                DispatchQueue.main.async {
                    self?.albumIV.image = image
                }
                return
                
            } catch let error {
                print("error is \(error)")
            }
        }
        
        lblTitle.text = "Title \(index)"
        lblSubTitle.text = "SubTitle \(index)"
    }
    
}

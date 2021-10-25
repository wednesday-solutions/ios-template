//
//  NoResultTableViewCell.swift
//  Template
//
//  Created by Rameez Khan on 25/10/21.
//

import UIKit

class NoResultTableViewCell: UITableViewCell {
    
    private let noResultLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = FontFamily.Roboto.black.font(size: 24.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(noResultLabel)
        NSLayoutConstraint.activate([
            noResultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            noResultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setTextForResult(_ text: String) {
        noResultLabel.text = text
    }
    
}

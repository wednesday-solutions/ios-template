//
//  NoResultTableCell.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class NoResultTableCell: UITableViewCell {

    private let noResultLable : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 24)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews() {
        self.addSubview(noResultLable)
        
        NSLayoutConstraint.activate([
            noResultLable.topAnchor.constraint(equalTo: self.topAnchor),
            noResultLable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            noResultLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            noResultLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func configureCell(text: String) {
        noResultLable.text = text
    }

}

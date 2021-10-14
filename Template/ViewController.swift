//
//  ViewController.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = L10n.welcome
        // Picking up color and font from generated files so no safe unwrapping during initialisation
        label.backgroundColor = Asset.accentColor.color
        label.font = FontFamily.Roboto.blackItalic.font(size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wednesdayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Picking up images from generated files so no need for safe unwrapping
        imageView.image = Asset.wednesday.image
        return imageView
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(label)
        view.addSubview(wednesdayImageView)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // imageViewConstraints
            wednesdayImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16.0),
            wednesdayImageView.heightAnchor.constraint(equalToConstant: 20.0),
            wednesdayImageView.widthAnchor.constraint(equalToConstant: 20.0),
            wednesdayImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Environment.serverUrl.absoluteString)
        print(SecretConfig.apiSecretKey)
        
        // Test swiftLint
//        var r = "test"
//        print("r is", r)
    }
}

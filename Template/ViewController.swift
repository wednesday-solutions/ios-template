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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Environment.serverUrl.absoluteString)
        print(SecretConfig.apiSecretKey)
        
        // Test swiftLint
        var r = "test"
        print("r is", r)
    }
}


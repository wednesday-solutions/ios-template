//
//  ViewController.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    var showDetail: (() -> Void)?
    let label: UILabel = {
        let label = UILabel()
        label.text = L10n.welcome
        // Picking up color and font from generated files so no safe unwrapping during initialisation
        label.backgroundColor = Asset.redColor.color
        label.font = FontFamily.Roboto.blackItalic.font(size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        // Picking up images from generated files so no need for safe unwrapping
        button.setImage(Asset.wednesday.image, for: .normal)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(wednesdayButton)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // buttonConstraints
            wednesdayButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16.0),
            wednesdayButton.heightAnchor.constraint(equalToConstant: 20.0),
            wednesdayButton.widthAnchor.constraint(equalToConstant: 20.0),
            wednesdayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(Environment.serverUrl.absoluteString)
        print(SecretConfig.apiSecretKey)
        setUpButton()
        // Test swiftLint
//        var r = "test"
//        print("r is", r)
    }
    
    private func setUpButton() {
        wednesdayButton.addTarget(self, action: #selector(onWednesdayButtonSelected(_:)), for: .touchUpInside)
    }
    
    @objc func onWednesdayButtonSelected(_ button: UIButton) {
        showDetail?()
    }
}

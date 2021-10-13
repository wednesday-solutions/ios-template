//
//  ViewController.swift
//  Template
//
//  Created by Rameez Khan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {

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


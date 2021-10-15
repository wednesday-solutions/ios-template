//
//  DetailViewController.swift
//  Template
//
//  Created by Rameez Khan on 16/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = Asset.accentColor.color
    }
}

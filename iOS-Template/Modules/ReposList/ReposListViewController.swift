//
//  ReposListViewController.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import UIKit

class ReposListViewController: UIViewController {
  
  private let user: GithubUser
  
  init(user: GithubUser) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed
  }
  
}

//
//  RepoListViewController.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

class RepoListViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}

class RepoListViewModel {
  let user: String
  var repositories: [Repository] = []
  
  init(user: String) {
    self.user = user
  }
  
  func getRepos() {
    
  }
  
}

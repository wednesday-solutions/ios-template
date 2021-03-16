//
//  RepoListViewModel.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import Foundation

class RepoListViewModel {
  let user: String
  var repositories: [Repository] = []
  
  init(user: String) {
    self.user = user
  }
  
  func getRepos(completion: @escaping () -> Void) {
    Networking().getRepos(user: user) { (result) in
      switch result {
      case let .success(repos):
        self.repositories = repos
        completion()
      case let .failure(error):
        // Maybe show a UI Alert on screen
        dump(error)
        return
      }
    }
    
  }
  
}

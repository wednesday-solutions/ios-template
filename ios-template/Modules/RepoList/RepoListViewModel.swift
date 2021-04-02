//
//  RepoListViewModel.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import Foundation

final class RepoListViewModel {
  let user: String
  private (set) var repositories: [Repository] = []
  private var nextPage: Int = 1
  var networking: Endpoints
  
  init(user: String, networking: Endpoints) {
    self.user = user
    self.networking = networking
  }
  
  func searchForUserRepositories(callback: @escaping Callback<Result<[Repository], NetworkingError>>) {
    self.nextPage = 1
    searchUserRepositories { (result) in
      callback(result)
    }
  }
  
  private func searchUserRepositories(callback: @escaping Callback<Result<[Repository], NetworkingError>>) {
    networking.getRepos(user: user) { (result) in
      switch result {
      case .success(let repos):
        self.repositories += repos
        self.nextPage += 1
      case .failure(let error):
        // FIXME: Handle Error
        dump(error)
      }
      callback(result)
    }
  }
    
}

//
//  RepoListViewModel.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import Foundation

class RepoListViewModel {
  let user: String
  private (set) var repositories: [Repository] = []
  private var nextPage: Int = 1
  private var inFlightRequest: URLSessionDataTask? // This variable is not being used
  var onDataLoad: (() -> Void)?
  
  init(user: String) {
    self.user = user
  }
  
  func endOfPageReached() {
    makeNetworkCall()
  }
  
  func searchForUserRepositories() {
    makeNetworkCall()
  }
  
  private func makeNetworkCall() {
    let dataTask = Networking().getRepos(user: user) { (result) in
      switch result {
      case .success(let repos):
        self.repositories += repos
        self.onDataLoad?()
        self.nextPage += 1
      case .failure(let error):
        dump(error)
      }
    }
    self.inFlightRequest = dataTask
  }
    
}

//
//  RepositoriesListViewModel.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import Combine
import Foundation

class RepositoriesListViewModel: ObservableObject {
  
  private let user: GithubUser
  @Published private(set) var repositories: Result<[Repository], NetworkingError> = .success([])
  private let networkingController = NetworkingController()
  
  init(user: GithubUser) {
    self.user = user
    networkingController.reposPublisher(for: user)
      .asResult()
      .receive(on: DispatchQueue.main)
      .assign(to: &$repositories)
  }
  
}

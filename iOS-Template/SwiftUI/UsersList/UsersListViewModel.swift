//
//  UsersListViewModel.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import SwiftUI

class UsersListViewModel: ObservableObject {
  
  @Published var searchText = ""
  @Published private(set) var users: Result<[GithubUser], NetworkingError> = .success([])
  private let networkingController = NetworkingController()
  
  init() {
    $searchText
      .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
      .removeDuplicates()
      .filter { $0.isEmpty == false }
      .flatMap { [networkingController] in networkingController.usersPublisher(query: $0) }
      .asResult()
      .receive(on: DispatchQueue.main)
      .assign(to: &$users)
  }
  
}

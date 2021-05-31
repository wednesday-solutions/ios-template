//
//  UsersListViewModel.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import Combine
import SwiftUI

class UsersListViewModel: ObservableObject {
  
  @Published var searchText = ""
  @Published private(set) var results: Result<[GithubUser], NetworkingError> = .success([])
  private let networkingController = NetworkingController()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $searchText
      .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
      .removeDuplicates()
      .filter { $0.isEmpty == false }
      .flatMap { [networkingController] in networkingController.usersPublisher(query: $0) }
      .asResult()
      .receive(on: DispatchQueue.main)
      .assign(to: \.results, on: self)
      .store(in: &cancellables)
  }
  
}

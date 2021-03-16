//
//  UserSearchCoordinator.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

class UserSearchCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
  private let searchText: String
  private var userSearchViewController: UserSearchViewController?
  private var reposListCoordinator: ReposListCoordinator?
  
  init(presenter: UINavigationController?, searchText: String) {
    self.presenter = presenter
    self.searchText = searchText
  }
  
  func start() {
    let usersViewModel = UsersViewModel(searchText: searchText)
    let userSearchViewController = UserSearchViewController(viewModel: usersViewModel)
    userSearchViewController.delegate = self
    userSearchViewController.title = "Users"
    presenter?.pushViewController(userSearchViewController, animated: true)
    self.userSearchViewController = userSearchViewController
  }
  
}

extension UserSearchCoordinator: UserSearchDelegate {
  func userSearchResultsDidSelectUser(_ user: String) {
    let reposListCoordinator = ReposListCoordinator(presenter: presenter, user: user)
    reposListCoordinator.start()
    self.reposListCoordinator = reposListCoordinator
    
  }
}

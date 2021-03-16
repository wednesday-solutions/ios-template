//
//  Coordinator.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

protocol Coordinator {
  func start()
}

class ApplicationCoordinator: Coordinator {
  let window: UIWindow
  let rootViewController: UINavigationController
  let homeCoordinator: HomeCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()
    rootViewController.navigationBar.prefersLargeTitles = true
    homeCoordinator = HomeCoordinator(presenter: rootViewController)
  }
  
  func start() {
    window.rootViewController = rootViewController
    homeCoordinator.start()
    window.makeKeyAndVisible()
  }
}

class HomeCoordinator: Coordinator {
  private let presenter: UINavigationController
  private var homeViewController: HomeViewController?
  private var userSearchResultsCoordinator: UserSearchResultsCoordinator?
  
  init(presenter: UINavigationController) {
    self.presenter = presenter
  }
  
  func start() {
    let homeViewController = HomeViewController(nibName: nil, bundle: nil)
    homeViewController.delegate = self
    homeViewController.title = "Github User Search"
    presenter.pushViewController(homeViewController, animated: true)
    
    self.homeViewController = homeViewController
  }
  
}

extension HomeCoordinator: HomeViewControllerDelegate {
  func homeViewControllerDidSearch(_ searchTerm: String) {
    let userSearchResultsCoordinator = UserSearchResultsCoordinator(presenter: presenter, searchText: searchTerm)
    userSearchResultsCoordinator.start()
    self.userSearchResultsCoordinator = userSearchResultsCoordinator
  }
  
}

class UserSearchResultsCoordinator: Coordinator {
  private let presenter: UINavigationController
  private let searchText: String
  private var usersViewController: UsersViewController?
  private var reposListCoordinator: ReposListCoordinator?
  
  init(presenter: UINavigationController, searchText: String) {
    self.presenter = presenter
    self.searchText = searchText
  }
  
  func start() {
    let usersViewModel = UsersViewModel(searchText: searchText)
    let searchResultsViewController = UsersViewController(viewModel: usersViewModel)
    searchResultsViewController.delegate = self
    self.usersViewController = searchResultsViewController
    presenter.pushViewController(searchResultsViewController, animated: true)
  }
  
}

extension UserSearchResultsCoordinator: UserSearchResultsDelegate {
  func userSearchResultsDidSelectUser(_ user: String) {
    let reposListCoordinator = ReposListCoordinator(presenter: presenter, user: user)
    reposListCoordinator.start()
    self.reposListCoordinator = reposListCoordinator
    
  }
}

class ReposListCoordinator: Coordinator {
  private let presenter: UINavigationController
  private let user: String
  private var reposListViewController: RepoListViewController?
  
  init(presenter: UINavigationController, user: String) {
    self.presenter = presenter
    self.user = user
  }
  
  func start() {
    let repoViewModel = RepoListViewModel(user: user)
    let repoListViewController = RepoListViewController(viewModel: repoViewModel)
    self.reposListViewController = repoListViewController
    presenter.pushViewController(repoListViewController, animated: true)
  }
}

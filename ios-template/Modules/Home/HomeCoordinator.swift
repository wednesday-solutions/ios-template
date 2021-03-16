//
//  HomeCoordinator.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

class HomeCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
  private var homeViewController: HomeViewController?
  private var userSearchCoordinator: UserSearchCoordinator?
  
  init(presenter: UINavigationController?) {
    self.presenter = presenter
  }
  
  func start() {
    let homeViewController = HomeViewController(nibName: nil, bundle: nil)
    homeViewController.delegate = self
    homeViewController.title = "Github User Search"
    presenter?.pushViewController(homeViewController, animated: true)
    self.homeViewController = homeViewController
  }
  
}

extension HomeCoordinator: HomeViewControllerDelegate {
  func homeViewControllerDidSearch(_ searchTerm: String) {
    let userSearchCoordinator = UserSearchCoordinator(presenter: presenter, searchText: searchTerm)
    userSearchCoordinator.start()
    self.userSearchCoordinator = userSearchCoordinator
  }
  
}

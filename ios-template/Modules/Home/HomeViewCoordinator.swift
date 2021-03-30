//
//  HomeViewCoordinator.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import UIKit

class HomeViewCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
  private var homeViewController: HomeViewController?
  private var repoListCoordinator: ReposListCoordinator?
  
  init(presenter: UINavigationController?) {
    self.presenter = presenter
  }
  
  func start() {
    let homeViewController = HomeViewController()
    homeViewController.delegate = self
    presenter?.pushViewController(homeViewController, animated: true)
    self.homeViewController = homeViewController
  }
  
}

extension HomeViewCoordinator: HomeViewControllerDelegate {
  
  func homeViewControllerDidSelect(_ user: String) {
    let repoListCoordinator = ReposListCoordinator(presenter: self.presenter, user: user)
    repoListCoordinator.start()
    self.repoListCoordinator = repoListCoordinator
  }
  
}

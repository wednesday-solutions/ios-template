//
//  HomeViewCoordinator.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import UIKit

final class HomeViewCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
  private var homeViewController: HomeViewController?
  private var repoListCoordinator: ReposListCoordinator?
  private let environment: Environment
  
  init(presenter: UINavigationController?, environment: Environment) {
    self.presenter = presenter
    self.environment = environment
  }
  
  func start() {
    let homeViewModel = HomeViewModel(networking: environment.networking.copy())
    let homeViewController = HomeViewController(viewModel: homeViewModel)
    homeViewController.delegate = self
    presenter?.pushViewController(homeViewController, animated: true)
    self.homeViewController = homeViewController
  }
  
}

extension HomeViewCoordinator: HomeViewControllerDelegate {
  
  func homeViewControllerDidSelect(_ user: String) {
    let repoListCoordinator = ReposListCoordinator(presenter: self.presenter, user: user, environment: self.environment)
    repoListCoordinator.start()
    self.repoListCoordinator = repoListCoordinator
  }
  
}

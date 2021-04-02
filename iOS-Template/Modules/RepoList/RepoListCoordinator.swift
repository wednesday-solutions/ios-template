//
//  RepoListCoordinator.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import UIKit

final class ReposListCoordinator: Coordinator {
  private let user: String
  private let environment: Environment
  private weak var presenter: UINavigationController?
  private var reposListViewController: RepoListViewController?
  
  init(presenter: UINavigationController?, user: String, environment: Environment) {
    self.presenter = presenter
    self.user = user
    self.environment = environment
  }
  
  func start() {
    let repoListViewModel = RepoListViewModel(user: user, networking: self.environment.networking.copy())
    let repoListViewController = RepoListViewController(viewModel: repoListViewModel)
    repoListViewController.title = "Repos for \(user)"
    self.reposListViewController = repoListViewController
    presenter?.pushViewController(repoListViewController, animated: true)
  }
}

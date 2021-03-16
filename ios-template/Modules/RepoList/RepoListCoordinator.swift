//
//  RepoListCoordinator.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

class ReposListCoordinator: Coordinator {
  private weak var presenter: UINavigationController?
  private let user: String
  private var reposListViewController: RepoListViewController?
  
  init(presenter: UINavigationController?, user: String) {
    self.presenter = presenter
    self.user = user
  }
  
  func start() {
    let repoListViewModel = RepoListViewModel(user: user)
    let repoListViewController = RepoListViewController(viewModel: repoListViewModel)
    repoListViewController.title = "Repos for \(user)"
    self.reposListViewController = repoListViewController
    presenter?.pushViewController(repoListViewController, animated: true)
  }
}

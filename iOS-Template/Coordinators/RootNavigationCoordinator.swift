//
//  RootNavigationCoordinator.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

final class RootNavigationCoordinator: NSObject, NavigationCoordinator {
  
  private(set) var controller: UINavigationController
  private(set) var childCoordinators: [Coordinator] = []
  private let environment: Environment
  
  init(navigationController: UINavigationController = .init(), environment: Environment) {
    self.controller = navigationController
    self.environment = environment
  }
  
  private func makeRootViewController() -> UIViewController {
    let viewController = UIViewController()
    viewController.view.backgroundColor = .systemGreen
    return viewController
  }
  
  func start() {
    controller.pushViewController(makeRootViewController(), animated: false)
  }
  
}

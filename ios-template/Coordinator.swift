//
//  Coordinator.swift
//  iOS-Template
//
//  Created by Viranchee on 30/03/21.
//

import UIKit

protocol Coordinator {
  func start()
}

class ApplicationCoordinator: Coordinator {
  let window: UIWindow
  let rootViewController: UINavigationController
  let homeViewCoordinator: HomeViewCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()
    rootViewController.navigationBar.prefersLargeTitles = true
    homeViewCoordinator = HomeViewCoordinator(presenter: rootViewController)
  }
  
  func start() {
    window.rootViewController = rootViewController
    homeViewCoordinator.start()
    window.makeKeyAndVisible()
  }
}

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

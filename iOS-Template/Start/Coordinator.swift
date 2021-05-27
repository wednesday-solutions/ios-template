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

final class ApplicationCoordinator: Coordinator {
  let window: UIWindow
  let rootViewController: UINavigationController
  let homeViewCoordinator: HomeViewCoordinator
  let environment: Environment
  
  init(window: UIWindow, environment: Environment) {
    self.window = window
    self.environment = environment
    
    rootViewController = UINavigationController()
    rootViewController.navigationBar.prefersLargeTitles = true
    homeViewCoordinator = HomeViewCoordinator(presenter: rootViewController, environment: self.environment)
  }
  
  func start() {
    window.rootViewController = rootViewController
    homeViewCoordinator.start()
    window.makeKeyAndVisible()
  }
}

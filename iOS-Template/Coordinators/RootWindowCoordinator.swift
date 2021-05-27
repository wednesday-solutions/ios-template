//
//  RootWindowCoordinator.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

class RootWindowCoordinator: NSObject, WindowCoordinator {
  
  private(set) var window: UIWindow
  private(set) var childCoordinators: [Coordinator] = []
  private let environment: Environment
  
  init(window: UIWindow, environment: Environment) {
    self.window = window
    self.environment = environment
    super.init()
  }
  
  convenience init?(scene: UIScene, environment: Environment) {
    guard let windowScene = scene as? UIWindowScene else { return nil }
    self.init(window: UIWindow(windowScene: windowScene), environment: environment)
  }
  
  func start() {
    let coordinator = RootNavigationCoordinator(environment: environment)
    childCoordinators.append(coordinator)
    window.rootViewController = coordinator.controller
    window.makeKeyAndVisible()
    coordinator.start()
  }
  
}

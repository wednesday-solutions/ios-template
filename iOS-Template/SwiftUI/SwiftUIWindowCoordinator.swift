//
//  SwiftUIWindowCoordinator.swift
//  iOS-Template
//
//  Created by apple on 31/05/21.
//

import SwiftUI

class SwiftUIWindowCoordinator: NSObject, WindowCoordinator {
  
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
    let view = makeView()
    window.rootViewController = UIHostingController(rootView: view)
    window.makeKeyAndVisible()
  }
  
  func makeView() -> some View {
    UsersListView()
  }
  
}

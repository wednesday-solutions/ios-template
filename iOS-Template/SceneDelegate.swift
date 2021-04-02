//
//  SceneDelegate.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private var applicationCoordinator: ApplicationCoordinator?
  var environment: Environment!

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    
    #if DEBUG
    environment = .live
    #else
    environment = .live
    #endif
    
    let applicationCoordinator = ApplicationCoordinator(window: window, environment: environment)
    window.windowScene = windowScene
    self.window = window
    self.applicationCoordinator = applicationCoordinator
    
    applicationCoordinator.start()

  }
  
}

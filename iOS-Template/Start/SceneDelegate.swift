//
//  SceneDelegate.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private var windowCoordinator: RootWindowCoordinator!

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let coordinator = RootWindowCoordinator(scene: scene, environment: .current) else {
      fatalError("Unexpected UIScene: \(scene)")
    }
    coordinator.start()
    self.windowCoordinator = coordinator
  }

}

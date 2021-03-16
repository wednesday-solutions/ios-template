//
//  SceneDelegate.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    //  Open ViewController Programatically
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let homeViewController = HomeViewController()
    let navigationController = UINavigationController(rootViewController: homeViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
  }
  
}

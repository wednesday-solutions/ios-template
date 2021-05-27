//
//  NavigationCoordinator.swift
//  Pods
//
//  Created by apple on 27/05/21.
//

import UIKit

protocol NavigationCoordinator: Coordinator {
  
  var controller: UINavigationController { get }
  
  var childCoordinators: [Coordinator] { get }
  
}

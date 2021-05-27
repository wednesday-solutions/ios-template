//
//  WindowCoordinator.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

protocol WindowCoordinator: Coordinator {
  
  var window: UIWindow { get }
  
  var childCoordinators: [Coordinator] { get }
  
}

//
//  Coordinator.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    func start()
    var childCoordinators : [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
}

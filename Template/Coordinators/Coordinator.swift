//
//  Coordinator.swift
//  Template
//
//  Created by Rameez Khan on 14/10/21.
//

import UIKit
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

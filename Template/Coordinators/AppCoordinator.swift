//
//  AppCoordinator.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import Foundation
import UIKit


class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let rootViewController = HomeVC()
        
        rootViewController.showDetail = { [weak self] in
            self?.showDetail()
        }
        
        navigationController.navigationBar.barStyle = .black
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func showDetail() {
        let detailVC = DetailVC()
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}

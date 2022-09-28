//
//  AppCoordinator.swift
//  Template
//
//  Created by Rameez Khan on 16/10/21.
//

import UIKit
class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var goToDetail: (() -> Void)?

    private var tabBarController: UITabBarController
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = HomeTabBarController()
    }

    func start() {
        navigationController.delegate = self
        
        let homeCoordinator = HomeViewCoordinator()
        homeCoordinator.start()
        tabBarController.viewControllers = [homeCoordinator.navigationController]
        childCoordinators.append(homeCoordinator)
        navigationController.navigationBar.barStyle = .black
        navigationController.pushViewController(tabBarController, animated: false)
    }
    
    
    func childDidFinish(_ child: Coordinator?) {
        for(index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let detailController = fromViewController as? DetailViewController {
            childDidFinish(detailController.coordinator)
        }
    }
}

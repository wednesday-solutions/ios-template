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

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let rootViewController = ViewController()
        // Create separate coordinators as the app grows
        rootViewController.showDetail = { [weak self] in
            self?.showDetail()
        }
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    private func showDetail() {
        let detailViewController = DetailViewController()
        navigationController.pushViewController(detailViewController, animated: true)
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

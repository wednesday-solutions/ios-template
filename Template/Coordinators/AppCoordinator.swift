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
        let itunesApiService = ItunesApiService()
        let searchViewModel = SearchViewModel(with: itunesApiService)
        let rootViewController = ViewController(with: searchViewModel)
        // Create separate coordinators as the app grows
        rootViewController.showDetail = { [weak self] result in
            self?.showDetail(with: result)
        }
        navigationController.navigationBar.barStyle = .black
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    private func showDetail(with result: ItunesResult) {
        // A new coordinator can be declared here which can take care of the flow 
        let detailViewController = DetailViewController(with: result)
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

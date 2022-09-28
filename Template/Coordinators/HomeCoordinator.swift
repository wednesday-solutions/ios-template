//
//  HomeCoordinator.swift
//  Template
//
//  Created by Apple on 23/09/22.
//

import UIKit

class HomeViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        navigationController = UINavigationController()
        self.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)       
    }
    
    func start() {
        let itunesApiService = ItunesApiService()
        let searchViewModel = SearchViewModel(with: itunesApiService)
        let rootViewController = ViewController(with: searchViewModel)
        rootViewController.showDetail = { [weak self] result in
            self?.showDetail(with: result)
        }
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    private func showDetail(with result: ItunesResult) {
        // A new coordinator can be declared here which can take care of the flow
        let detailViewController = DetailViewController(with: result)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}

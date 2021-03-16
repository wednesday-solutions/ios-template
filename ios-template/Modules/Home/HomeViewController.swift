//
//  HomeViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  
  var searchBar = UISearchBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    layoutViews()
  }
  
  func layoutViews() {
    view.backgroundColor = .systemGreen
    title = "Github User Search"
    
    view.addSubview(searchBar)
    // Search Bar Layout
    searchBar.snp.makeConstraints { (make) in
      make.width.equalTo(view)
      make.center.equalTo(view.snp.center)
    }
    
  }
  
}

extension HomeViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else {
      // There was no search text
      // Maybe show an error
      return
    }
    let usersViewModel = UsersViewModel(searchText: searchText)
    let searchResultsViewController = UsersViewController(viewModel: usersViewModel)
    
    navigationController?.pushViewController(searchResultsViewController, animated: true)
    
  }
}

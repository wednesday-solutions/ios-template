//
//  HomeViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: class {
  func homeViewControllerDidSearch(_ searchTerm: String)
}

class HomeViewController: UIViewController {
  weak var delegate: HomeViewControllerDelegate!
  
  var searchBar = UISearchBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    layoutViews()
  }
  
  func layoutViews() {
    view.backgroundColor = .systemGreen
//    title = "Github User Search"
    
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
    delegate.homeViewControllerDidSearch(searchText)

  }
}

//
//  UserSearchViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

protocol UserSearchDelegate: class {
  func userSearchResultsDidSelectUser(_ user: String)
}

class UserSearchViewController: UITableViewController {
  weak var delegate: UserSearchDelegate!
  
  let viewModel: UserSearchViewModel
  
  init(viewModel: UserSearchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerCell(UITableViewCell.self)
    viewModel.searchUsers {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.userList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    cell.textLabel?.text = viewModel.getNameFor(userAt: indexPath.row)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    defer {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    let user = viewModel.getNameFor(userAt: indexPath.row)
    delegate.userSearchResultsDidSelectUser(user)
  }
  
}

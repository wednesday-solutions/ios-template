//
//  SearchResultsViewController.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

class UsersViewController: UITableViewController {
  
  let viewModel: UsersViewModel
  
  init(viewModel: UsersViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Users"
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
    cell.textLabel?.text = viewModel.userList[indexPath.row].login
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}


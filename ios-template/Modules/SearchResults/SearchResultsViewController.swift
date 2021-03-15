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
    let cell = UITableViewCell()
    let user = viewModel.userList[indexPath.row]
    cell.textLabel?.text = user.login
    return cell
  }
  
}

class UsersViewModel {
  let searchText: String
  var userList: [GithubUser] = []
  
  init(searchText: String) {
    self.searchText = searchText
  }
  
  func searchUsers(closure: @escaping () -> Void ) {
    Networking().searchUsers(query: searchText) { (result) in
      switch result {
      case let .success(model):
        self.userList = model.items
      case let .failure(error):
        dump(error)
      }
      closure()
    }
  }
}

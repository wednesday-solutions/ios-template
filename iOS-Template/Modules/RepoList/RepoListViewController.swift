//
//  RepoListViewController.swift
//  ios-template
//
//  Created by Viranchee on 16/03/21.
//

import UIKit

final class RepoListViewController: UITableViewController {
  
  let viewModel: RepoListViewModel
  
  init(viewModel: RepoListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Repos for \(viewModel.user)"
    tableView.registerCell(UITableViewCell.self)
    tableView.accessibilityLabel = "List of repositories"
    viewModel.searchForUserRepositories { [weak self] _ in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.repositories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    let repoName = viewModel.repositories[indexPath.row].name
    cell.textLabel?.text = repoName
    cell.accessibilityLabel = repoName
    return cell
  }
}

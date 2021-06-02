//
//  GitHubUsersDataSource.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

class GitHubUsersDataSource: UICollectionViewDiffableDataSource<Int, Int> {
  
  /// An array of users to be shown in this data source's collection view.
  private var users: [GithubUser]
  
  subscript(id: GithubUser.ID) -> GithubUser? {
    users.first(where: { $0.id == id })
  }
  
  subscript(indexPath: IndexPath) -> GithubUser {
    users[indexPath.item]
  }
  
  override init(
    collectionView: UICollectionView,
    cellProvider: @escaping UICollectionViewDiffableDataSource<Int, Int>.CellProvider
  ) {
    users = []
    super.init(collectionView: collectionView, cellProvider: cellProvider)
    replaceExistingUsers(with: users)
  }
  
  /// Removes existing users in the data source's collection view and inserts the provided array with new users.
  /// - Parameter newUsers: An array of new users to replace in the collection view.
  func replaceExistingUsers(with newUsers: [GithubUser]) {
    let section = 0
    var sectionSnapshot = snapshot(for: section)
    sectionSnapshot.delete(users.map(\.id))
    self.users = newUsers
    sectionSnapshot.append(users.map(\.id))
    apply(sectionSnapshot, to: section)
  }
  
}

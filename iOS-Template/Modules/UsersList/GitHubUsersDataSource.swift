//
//  GitHubUsersDataSource.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

class GitHubUsersDataSource: UICollectionViewDiffableDataSource<Int, Int> {
  
  private(set) var users: [GithubUser] = []
  
  subscript(id: GithubUser.ID) -> GithubUser? {
    users.first(where: { $0.id == id })
  }
  
  func replaceExistingUsers(with newUsers: [GithubUser]) {
    let section = 0
    var sectionSnapshot = snapshot(for: section)
    sectionSnapshot.delete(users.map(\.id))
    self.users = newUsers
    sectionSnapshot.append(users.map(\.id))
    apply(sectionSnapshot, to: section)
  }
  
}
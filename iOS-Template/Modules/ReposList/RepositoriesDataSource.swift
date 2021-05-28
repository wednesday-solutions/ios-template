//
//  RepositoriesDataSource.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import UIKit

final class RepositoriesDataSource: UICollectionViewDiffableDataSource<Int, Int> {
  
  private var repositories: [Repository] = []
  
  subscript(indexPath: IndexPath) -> Repository {
    repositories[indexPath.item]
  }
  
  override init(
    collectionView: UICollectionView,
    cellProvider: @escaping UICollectionViewDiffableDataSource<Int, Int>.CellProvider
  ) {
    super.init(collectionView: collectionView, cellProvider: cellProvider)
    replaceExistingRepositories(with: [])
  }
  
  func replaceExistingRepositories(with newRepositories: [Repository]) {
    let section = 0
    var sectionSnapshot = snapshot(for: section)
    sectionSnapshot.delete(repositories.map(\.id))
    self.repositories = newRepositories
    sectionSnapshot.append(repositories.map(\.id))
    apply(sectionSnapshot, to: section)
  }
  
}

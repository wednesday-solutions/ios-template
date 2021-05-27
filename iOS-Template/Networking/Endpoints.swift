//
//  Endpoints.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import UIKit

protocol Endpoints {
  func copy() -> Self
  mutating func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void)
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void)
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void)
}

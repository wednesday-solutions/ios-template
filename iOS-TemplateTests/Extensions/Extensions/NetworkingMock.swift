//
//  NetworkingMock.swift
//  iOS-TemplateTests
//
//  Created by Viranchee on 02/04/21.
//

import UIKit
@testable import iOS_Template

struct NetworkingMock: Endpoints {
  
  func copy() -> NetworkingMock {
    return Self()
  }
  
  mutating func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      let repos: [Repository] = [
        Repository(name: "Repo1", id: 1),
        Repository(name: "Repo2", id: 2),
        Repository(name: "Repo3", id: 3)
      ]
      completion(.success(repos))
    }
  }
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      let model = GithubModel(
        totalCount: 3,
        incompleteResults: false,
        items: [
          GithubUser(login: "Viranchee", id: 1),
          GithubUser(login: "virancheewednesday", id: 2),
          GithubUser(login: "rameez", id: 3)
        ]
      )
      completion(.success(model))
    }
  }
  
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      
      completion(.failure(.noDataError))
    }
  }
  
}

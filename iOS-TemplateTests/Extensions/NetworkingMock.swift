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
        Repository(name: "Repo1"),
        Repository(name: "Repo2"),
        Repository(name: "Repo3")
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
          GithubUser(login: "Viranchee"),
          GithubUser(login: "virancheewednesday"),
          GithubUser(login: "rameez")
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

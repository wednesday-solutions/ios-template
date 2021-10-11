//
//  GitRepoMockAPI.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import Foundation
@testable import iOS_Template

struct GitReposMockAPI: GitReposAPIProtocol {
    mutating func getRepos(of user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
      DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
        let repos: [Repository] = [
          Repository(name: "Repo1"),
          Repository(name: "Repo2"),
          Repository(name: "Repo3")
        ]
        completion(.success(repos))
      }
    }
}

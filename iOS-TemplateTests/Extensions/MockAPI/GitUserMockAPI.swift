//
//  GitUserMockAPI.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import Foundation
@testable import iOS_Template

struct GitUsersMockAPI: GitUserAPIProtocol {
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
}

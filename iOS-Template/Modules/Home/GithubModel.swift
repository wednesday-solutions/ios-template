// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct GithubModel: Codable {
  let totalCount: Int
  let incompleteResults: Bool
  let items: [GithubUser]
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case incompleteResults = "incomplete_results"
    case items
  }
}

// MARK: - Item
struct GithubUser: Codable, Identifiable {
  
  let login: String
  let id: Int
  
}

extension Array where Element == GithubUser {
  
  static var placholderList: [GithubUser] {
    [
      GithubUser(login: "ASDF1", id: 1),
      GithubUser(login: "ASDF2", id: 2),
      GithubUser(login: "ASDF3", id: 3),
      GithubUser(login: "ASDF4", id: 4),
      GithubUser(login: "ASDF5", id: 5)
    ]
  }
  
}

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
struct GithubUser: Codable {
  let login: String
}

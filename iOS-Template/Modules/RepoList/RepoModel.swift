// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let githubUser = try? newJSONDecoder().decode(GithubUser.self, from: jsonData)

import Foundation

// MARK: - Repository
struct Repository: Codable, Identifiable {
  
  let name: String
  let id: Int
  
}

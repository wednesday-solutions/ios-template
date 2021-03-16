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
  let id: Int
  let nodeID: String
  let avatarURL: String
  let gravatarID: String
  let url, htmlURL, followersURL: String
  let followingURL, gistsURL, starredURL: String
  let subscriptionsURL, organizationsURL, reposURL: String
  let eventsURL: String
  let receivedEventsURL: String
  let siteAdmin: Bool
  let score: Int
  
  enum CodingKeys: String, CodingKey {
    case login, id
    case nodeID = "node_id"
    case avatarURL = "avatar_url"
    case gravatarID = "gravatar_id"
    case url
    case htmlURL = "html_url"
    case followersURL = "followers_url"
    case followingURL = "following_url"
    case gistsURL = "gists_url"
    case starredURL = "starred_url"
    case subscriptionsURL = "subscriptions_url"
    case organizationsURL = "organizations_url"
    case reposURL = "repos_url"
    case eventsURL = "events_url"
    case receivedEventsURL = "received_events_url"
    case siteAdmin = "site_admin"
    case score
  }
  
}

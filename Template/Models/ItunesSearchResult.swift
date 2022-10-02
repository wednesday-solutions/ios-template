//
//  ItunesSearchResult.swift
//  Template
//
//  Created by Rameez Khan on 19/10/21.
//

import Foundation
struct ItunesSearchResult: Codable, Equatable {
    static func == (lhs: ItunesSearchResult, rhs: ItunesSearchResult) -> Bool {
        lhs.resultCount == rhs.resultCount
    }
    
    let resultCount: Int
    let results: [ItunesResult]
}

struct ItunesResult: Codable, Hashable {
    let id = UUID()
    let wrapperType: WrapperType?
    let kind: Kind?
    let artistID, collectionID: Int?
    let trackID: Int?
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: Explicitness?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: Country
    let currency: Currency
    let primaryGenreName: String
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistViewURL: String?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let contentAdvisoryRating, shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let collectionArtistName: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        // swiftlint:disable line_length
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case contentAdvisoryRating, shortDescription, longDescription, hasITunesExtras, collectionArtistName
    }
}

enum Explicitness: String, Codable {
    case notExplicit
    case explicit
    case cleaned
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case featureMovie = "feature-movie"
    case song = "song"
    case tvEpisode = "tv-episode"
}

enum WrapperType: String, Codable {
    case track = "track"
    case audioBook = "audiobook"
}

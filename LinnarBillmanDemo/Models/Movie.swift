//
//  Movie.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let rating: Double
    let imdbUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, rating
        case name = "movie"
        case imdbUrl = "imdb_url"
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.rating == rhs.rating && lhs.imdbUrl == rhs.imdbUrl
    }
}

/// Defining protocol makes mocking and testing easier
protocol CacheableMovies {
    static func fetchDataFromBackend() async throws -> [Movie]
    static func getDataFromUserDefaults() -> [Movie]
    static func saveDataToUserDefaults(_ movies: [Movie])
    static func clearDataFromUserDefaults()
}

extension Movie: CacheableMovies {
    static func fetchDataFromBackend() async throws -> [Movie] {
        return try await DemoRestClient.shared.requestDecodable(router: .GetMovies, model: [Movie].self)
    }
    
    static func getDataFromUserDefaults() -> [Movie] {
        return UserDefaultsHelper.getDecodableDataFromUserDefaults(for: "LinnarDemoApp_Movies", model: [Movie].self) ?? []
    }
    
    static func saveDataToUserDefaults(_ movies: [Movie]) {
        UserDefaultsHelper.saveCodableDataToUserDefaults(movies, for: "LinnarDemoApp_Movies")
        Movie.saveCacheTimeStamp()
    }
    
    static func clearDataFromUserDefaults() {
        UserDefaultsHelper.clearDataFromUserDefaults(for: "LinnarDemoApp_Movies")
    }
    
    static func saveCacheTimeStamp() {
        UserDefaultsHelper.saveCacheTimeStamp(for: "LinnarDemoApp_Cache_Movie_Timestamp")
    }
    
    static func getCacheTimeStamp() -> Date? {
        return UserDefaultsHelper.getCacheTimeStamp(for: "LinnarDemoApp_Cache_Movie_Timestamp")
    }
}


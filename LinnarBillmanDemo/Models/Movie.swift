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
}

extension Movie {
    static func fetchDataFromBackend() async throws -> [Movie] {
        return try await DemoAPI.shared.client.getMovies()
    }
    
    static func getDataFromUserDefaults() -> [Movie] {
        return UserDefaultsHelper.getDecodableDataFromUserDefaults(for: .movies, model: [Movie].self) ?? []
    }
    
    static func saveDataToUserDefaults(_ movies: [Movie]) {
        UserDefaultsHelper.saveCodableDataToUserDefaults(movies, for: .movies)
        Movie.saveCacheTimeStamp()
    }
    
    static func clearDataFromUserDefaults() {
        UserDefaultsHelper.clearDataFromUserDefaults(for: .movies)
        UserDefaultsHelper.clearDataFromUserDefaults(for: .moviesCacheTimeStamp)
    }
    
    static func saveCacheTimeStamp() {
        UserDefaultsHelper.saveCacheTimeStamp(for: .moviesCacheTimeStamp)
    }
    
    static func getCacheTimeStamp() -> Date? {
        return UserDefaultsHelper.getCacheTimeStamp(for: .moviesCacheTimeStamp)
    }
}


//
//  LinnarBillmanDemoTests.swift
//  LinnarBillmanDemoTests
//
//  Created by Linnar Billman on 2024-11-18.
//

import Testing
import Foundation

struct LinnarBillmanDemoTests {

    @Test func textFetchDataFromBackend() async throws {
        let movies = try await MovieMock.fetchDataFromBackend()
        
        #expect(movies.count == 2)
        #expect(movies[0].name == "The Shawshank Redemption")
        #expect(movies[1].name == "The Godfather")
    }
    
    @Test func textClearToUserDefaults() async throws {
        MovieMock.clearDataFromUserDefaults()
        let movies = try await MovieMock.fetchDataFromBackend()
        #expect(MovieMock.getDataFromUserDefaults().isEmpty)
        MovieMock.saveDataToUserDefaults(movies)
        #expect(MovieMock.getDataFromUserDefaults().count == 2)
        MovieMock.clearDataFromUserDefaults()
        #expect(MovieMock.getDataFromUserDefaults().isEmpty)
    }
    
    @Test func textGetAndSaveToUserDefaults() async throws {
        let movies = try await MovieMock.fetchDataFromBackend()
        MovieMock.clearDataFromUserDefaults()
        #expect(MovieMock.getDataFromUserDefaults().isEmpty)
        MovieMock.saveDataToUserDefaults(movies)
        let retrievedMovies = MovieMock.getDataFromUserDefaults()
        #expect(retrievedMovies.count == 2)
        #expect(retrievedMovies[0].name == "The Shawshank Redemption")
        #expect(retrievedMovies[1].name == "The Godfather")
        MovieMock.clearDataFromUserDefaults()
    }
}

struct MovieMock: CacheableMovies {
    static func fetchDataFromBackend() async throws -> [Movie] {
        /// Ideally we would have a nice mocked backend when we test
        let movies = [
            Movie(id: 1, name: "The Shawshank Redemption", rating: 9.2, imdbUrl: URL(string: "https://www.imdb.com/title/tt0111161/")),
            Movie(id: 1, name: "The Godfather", rating: 9.2, imdbUrl: URL(string: "https://www.imdb.com/title/tt0068646/"))
        ]
        sleep(1)
        return movies
    }
    
    static func getDataFromUserDefaults() -> [Movie] {
        return UserDefaultsHelper.getDecodableDataFromUserDefaults(for: "LinnarDemoApp_Test_Movies", model: [Movie].self) ?? []
    }
    
    static func saveDataToUserDefaults(_ movies: [Movie]) {
        UserDefaultsHelper.saveCodableDataToUserDefaults(movies, for: "LinnarDemoApp_Test_Movies")
    }
    
    static func clearDataFromUserDefaults() {
        UserDefaultsHelper.clearDataFromUserDefaults(for: "LinnarDemoApp_Test_Movies")
    }
}

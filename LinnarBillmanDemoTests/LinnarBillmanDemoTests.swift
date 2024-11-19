//
//  LinnarBillmanDemoTests.swift
//  LinnarBillmanDemoTests
//
//  Created by Linnar Billman on 2024-11-18.
//

import Testing
import Foundation

struct LinnarBillmanDemoTests {
    @Test func textFetchMoviesFromBackend() async throws {
        DemoAPI.shared.environment = .mock
        Movie.clearDataFromUserDefaults()
        let movies = try await Movie.fetchDataFromBackend()
        
        #expect(movies.count == 2)
        #expect(movies[0].name == "The Shawshank Redemption")
        #expect(movies[1].name == "The Godfather")
    }
    
    @Test func textClearMoviesUserDefaults() async throws {
        DemoAPI.shared.environment = .mock
        Movie.clearDataFromUserDefaults()
        #expect(Movie.getDataFromUserDefaults().isEmpty)
        let movies = try await Movie.fetchDataFromBackend()
        Movie.saveDataToUserDefaults(movies)
        #expect(Movie.getDataFromUserDefaults().count == 2)
        Movie.clearDataFromUserDefaults()
        #expect(Movie.getDataFromUserDefaults().isEmpty)
    }
    
    @Test func textGetAndSaveMoviesUserDefaults() async throws {
        DemoAPI.shared.environment = .mock
        Movie.clearDataFromUserDefaults()
        #expect(Movie.getDataFromUserDefaults().isEmpty)
        let movies = try await Movie.fetchDataFromBackend()
        Movie.saveDataToUserDefaults(movies)
        let retrievedMovies = Movie.getDataFromUserDefaults()
        #expect(retrievedMovies.count == 2)
        #expect(retrievedMovies[0].name == "The Shawshank Redemption")
        #expect(retrievedMovies[1].name == "The Godfather")
        Movie.clearDataFromUserDefaults()
    }
}

//
//  MockAPIClient.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-19.
//

import Foundation

/// Other than running tests. This could be used for developing offline. As long as it's up to date with the actual backend.
/// If this was an app I was going to deploy I would create a dev-target and a prod-target of the app. Where the prod-target would not have access to this file.
class MockAPIClient: APIClient {
    let networkLayerClient: NetworkLayerClient = NetworkLayerClient()
    
    func loadJsonFile<T>(from fileName: String, model: T.Type) async throws -> T? where T: Decodable {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func getMovies() async throws -> [Movie] {
        return try await loadJsonFile(from: "movies", model: [Movie].self) ?? []
    }
    
    func getUsers() async throws -> [User] {
        return try await loadJsonFile(from: "users", model: [User].self) ?? []
    }
}

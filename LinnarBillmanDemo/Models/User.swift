//
//  User.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

struct Address: Codable, Equatable, Hashable {
    let street: String
    let city: String
    let state: String
    let zipcode: String
}

struct User: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address?
}

/// Defining protocol makes mocking and testing easier
protocol CacheableUsers {
    static func fetchDataFromBackend() async throws -> [User]
    static func getDataFromUserDefaults() -> [User]
    static func saveDataToUserDefaults(_ movies: [User])
    static func clearDataFromUserDefaults()
}

extension User: CacheableUsers {
    static func fetchDataFromBackend() async throws -> [User] {
        return try await DemoRestClient.shared.requestDecodable(router: .GetUsers, model: [User].self)
    }
    
    static func getDataFromUserDefaults() -> [User] {
        return UserDefaultsHelper.getDecodableDataFromUserDefaults(for: "LinnarDemoApp_Users", model: [User].self) ?? []
    }
    
    static func saveDataToUserDefaults(_ movies: [User]) {
        UserDefaultsHelper.saveCodableDataToUserDefaults(movies, for: "LinnarDemoApp_Users")
        User.saveCacheTimeStamp()
    }
    
    static func clearDataFromUserDefaults() {
        UserDefaultsHelper.clearDataFromUserDefaults(for: "LinnarDemoApp_Users")
    }
    
    static func saveCacheTimeStamp() {
        UserDefaultsHelper.saveCacheTimeStamp(for: "LinnarDemoApp_Cache_User_Timestamp")
    }
    
    static func getCacheTimeStamp() -> Date? {
        return UserDefaultsHelper.getCacheTimeStamp(for: "LinnarDemoApp_Cache_User_Timestamp")
    }
}


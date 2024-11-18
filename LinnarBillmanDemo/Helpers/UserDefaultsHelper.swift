//
//  UserDefaultsHelper.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

class UserDefaultsHelper {
    static func saveCacheTimeStamp(for key: String) {
        UserDefaults.standard.set(Date(), forKey: key)
    }
    
    static func getCacheTimeStamp(for key: String) -> Date? {
        guard let date = UserDefaults.standard.object(forKey: key) as? Date else {
            return nil
        }
        return date
    }
    
    static func getDecodableDataFromUserDefaults<T>(for key: String, model: T.Type) -> T? where T: Decodable {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode(T.self, from: data)
            return movies
        } catch {
            return nil
        }
    }
    
    static func saveCodableDataToUserDefaults<T>(_ object: T, for key: String) where T: Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(object) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func clearDataFromUserDefaults(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

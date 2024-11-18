//
//  APIClient.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation
import Combine

protocol RestClient {
    func requestDecodable<T>(router: Router, model: T.Type) async throws -> T where T : Decodable
}

class DemoRestClient: RestClient {
    
    static var shared: DemoRestClient = DemoRestClient()
    
    func requestDecodable<T>(router: Router, model: T.Type) async throws -> T where T : Decodable {
        let urlRequest = router.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let httpResponse = response as! HTTPURLResponse
        /// Remove comments to read api calls and responds
        /*debugPrint(urlRequest.debugDescription)
        debugPrint(httpResponse.debugDescription)
        if let dataString = String(data: data, encoding: String.Encoding.utf8) {
            debugPrint(dataString)
        }*/
        
        let statusCode = httpResponse.statusCode
        if 200..<299 ~= statusCode {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            let error = ApiError(error: nil, response: httpResponse)
            debugPrint(error.debugDescription)
            throw error
        }
    }
}

extension URLRequest {
    var debugDescription: String {
        return """
        [Request] \(String(describing: self.httpMethod)) \(String(describing: self.url))
        [Headers]: \(String(describing: self.allHTTPHeaderFields))
        [Body]: \(String(data: self.httpBody ?? Data(), encoding: .utf8) ?? "")
        """
    }
}

enum ApiErrorType: String {
    case BadRequest
    case Unauthorized
    case Forbidden
    case NotFound
    case CommunicationError
    case ClientError
    case ServerError
    case Unknown
    case NetworkTimeout
    case NoInternet
    case ServiceUnavailable
    
    var description: String {
        return rawValue
    }
}

class ApiError: Error {

    private var error: Error?
    private let response: HTTPURLResponse?

    let errorType: ApiErrorType
    
    init(error: Error?, response: HTTPURLResponse?) {
        self.error = error
        self.response = response
        self.errorType = ApiError.parseResponse(urlResponse: self.response, error: error)
    }
    
    var debugDescription: String {
        return "Debug Error=\(errorType.description) Error=\(String(describing: error)) response=\(String(describing: response))"
    }

    
    static func parseResponse(urlResponse: HTTPURLResponse?, error: Error?) -> ApiErrorType {
        if let response = urlResponse {
            switch response.statusCode {
            case 400:
                return .BadRequest
            case 401 :
                return .Unauthorized
            case 403:
                return .Forbidden
            case 404:
                return .NotFound
            case 400...499 :
                return .ClientError
            case 503:
                return .ServiceUnavailable
            case 500...599 :
                return .ServerError
            default:
                return .Unknown
            }
        } else if let error = error {
            switch error._code {
            case -1001:
                return .NetworkTimeout
            case -1009:
                return .NoInternet
            default:
                return .CommunicationError
            }
            
        } else {
            return .CommunicationError
        }
    }
}

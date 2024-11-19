//
//  Router.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

enum Router: URLRequestConvertible {
    case GetMovies
    case GetUsers
}

extension Router {
    
    private var encoding: ParameterEncoding {
        switch self {
        default:
            return .URLEncoding
        }
    }
    
    private var method: HttpMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var headers: [String: String]? {
        return nil
    }
    
    private var path: String {
        switch self {
        case .GetMovies:
            return "/movies"
        case .GetUsers:
            return "/users"
        }
    }
    
    private var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://dummyapi.online/api")!
    }
    
    func asURLRequest() -> URLRequest {
        let url = self.baseURL.appending(path: self.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        if let headers = self.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set parameters
        if let params = self.parameters {
            if self.encoding == .JSONEncoding {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params)
            } else {
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    for key in params.keys {
                        if let valueString = params[key] as? String {
                            let item = URLQueryItem(name: key, value: valueString)
                            if urlComponents.queryItems != nil {
                                urlComponents.queryItems?.append(item)
                            } else {
                                urlComponents.queryItems = [item]
                            }
                        }
                    }
                    urlRequest.url = urlComponents.url
                }
            }
        }
       
        
        return urlRequest
    }
}

enum ParameterEncoding {
    case URLEncoding
    case JSONEncoding
}

protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATH"
}


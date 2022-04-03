//
//  BaseRouter.swift
//  
//
//  Created by MacBook Pro on 31/3/2022.
//

import Foundation

struct HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
    static let delete = "DELETE"
}

enum BaseRouter {
    
    case getBookList
    
    public var httpMethod: String {
        switch self {
        case .getBookList:
            return HTTPMethod.get
        }
    }
    
    public var path: String {
        switch self {
        case .getBookList:
            return "books"
        }
    }
    
    public var params: [String: Any] {
        return [:]
    }
    
    public var baseUrl: URL {
        return URL(string: APIConfig.AppUrl.Base)!
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}

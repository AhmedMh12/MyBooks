//
//  Beer+API.swift
//  
//  Created by MacBook Pro on 31/3/2022.
//

import Foundation
import UIKit
import SwiftyJSON

class NetworkClient{
    
    public static func getBooksList(completion: @escaping (_ bookList: [Book], _ error: Error?) -> Void) {
        let router = BaseRouter.getBookList
        let request = HTTPRequest.request(router: router)
        HTTPResponse.response(with: request) { (json, error) in
            if let json = json {
                do {
                    let list: [Book] = try json.arrayValue.map { try Book.parse($0) }
                    completion(list, nil)
                } catch {
                    print(error)
                    completion([], nil)
                }
            } else {
                completion([], error)
            }
        }
    }

}

// REQUEST OFFLINE
extension NetworkClient {
    
    public static func getBeerListOffline(completion: @escaping (_ beerList: [Book], _ error: Error?) -> Void) {
        
        guard let filePath = Bundle.main.url(forResource: "Books",
                                             withExtension: "json") else {
            completion([], AppError.fileNotFound)
            return
        }

        do {
            let data = try Data.init(contentsOf: filePath)
            let json = try JSON(data: data)
            let list: [Book] = try json.arrayValue.map { try Book.parse($0) }
            completion(list, nil)
        } catch {
            completion([], error)
        }
    }
}

//
//  HTTPRequest.swift
//
//  Created by MacBook Pro on 31/3/2022.
//

import UIKit

class HTTPRequest {
    
    class func request(router: BaseRouter) -> URLRequest {
        
        var requestURL = router.baseUrl
        requestURL.appendPathComponent(router.path)
        var request = URLRequest(url: requestURL)
        request.httpMethod = router.httpMethod
        
        router.headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        switch router.httpMethod {
        case HTTPMethod.put, HTTPMethod.post:
            request.httpBody = try! JSONSerialization.data(withJSONObject: router.params,
                                                           options: [])
        case HTTPMethod.get:
            if !router.params.isEmpty {
                let params = router.params.map { "\($0)=\($1)" }.joined(separator: "&")
                request.url = request.url?.appendingPathComponent(String(format:"?%@", params))
            }
        default:
           break
        }
        
        debugPrint("REQUEST : \(request.url?.absoluteString ?? "")")
        debugPrint("REQUEST PARAMS : \(router.params)")
        
        return request
    }
}

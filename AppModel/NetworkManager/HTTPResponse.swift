//
//  HTTPResponse.swift
//
//  Created by MacBook Pro on 31/3/2022.

//

import UIKit
import SwiftyJSON

enum RESPONSE_CODE: Int {
    case SUCCESS = 200
    case ERROR = 400
}

class HTTPResponse: NSObject {

    class func response(with request: URLRequest,
                        completion: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        
        let task : URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                var json: JSON? = nil
                
                if let error = error {
                    print("ERROR RESPONSE (IF-ANY) :: \(error.localizedDescription)")
                    completion(json, error)
                } else {
                    let httpResponse = response as! HTTPURLResponse
                    print("HTTP RESPONSE \(httpResponse.description) && CODE :: \(httpResponse.statusCode)")
                    if (httpResponse.statusCode == RESPONSE_CODE.SUCCESS.rawValue) {
                        do {
                            let jsonObject = try JSONSerialization.jsonObject(with: data!,
                                                                              options: .allowFragments)
                            json = JSON(jsonObject)
                        }
                        catch let err {
                            print("RESPONSE_EXCEPTION :: \(err.localizedDescription)")
                        }
                        completion(json, error)
                    }
                    print("RESPONSE DATA :: \(json.debugDescription)")
                }
            }
        }
        task.resume()
    }

}

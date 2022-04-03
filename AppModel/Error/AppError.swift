//
//  AppError.swift
//  AppModel
//
//  Created by MacBook Pro on 31/3/2022.
//

import Foundation

enum AppError: Error {
    
    case fileNotFound
    case custom(message: String)
    
    var ErrorMessage: String {
        switch self {
        case .fileNotFound:
            return "File Not Found"
        case .custom(let message):
            return message
        }
    }
}

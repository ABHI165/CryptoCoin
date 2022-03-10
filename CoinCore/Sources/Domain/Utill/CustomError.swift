//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation

public enum CustomError: Error {
    case error(_ error: String)
}

extension CustomError: LocalizedError {
    
    public var errorDescription: String?{
        switch self {
        case .error(let message):
            return message
        }
    }
}

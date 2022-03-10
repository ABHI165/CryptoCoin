//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 18/02/22.
//

import Foundation

public enum BuildType: String, CaseIterable {
    case development
    case staging
    case production
}

extension BuildType {
    var commonBaseUrl: String {
        switch self {
        case .development:
            return "https://api.coingecko.com"
        case .staging:
            return "https://api.stg.coingecko.com"
        case .production:
            return "https://api.prod.coingecko.com"
        }
    }
}

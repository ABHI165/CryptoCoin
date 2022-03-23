//
//  GetCoinsEndpoints.swift
//  
//
//  Created by Abhishek Agarwal on 18/02/22.
//

import Foundation

public typealias Headers = [String: String]

public enum GetCoinsEndpoints {

    case getCoin(page: Int, order: String)
    case getStats

    var requestTimeOut: Float {
        return 30
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getCoin, .getStats:
            return .GET
        }
    }

  public  func createRequest( buildType: BuildType) throws -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: try getURL(from: buildType), headers: headers, reqBody: requestBody, reqTimeout: requestTimeOut, httpMethod: httpMethod)
    }

  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getCoin, .getStats:
            return nil
        default:
            return nil
        }
    }

  // compose urls for each request
    func getURL(from buildType: BuildType) throws -> String {
        let baseUrl = buildType.commonBaseUrl
        let basePath = "/api/v3/"
        var urlComponnent = URLComponents(string: baseUrl)
        switch self {
        case .getCoin(let pageNo, let order):
            urlComponnent?.path = "\(basePath)coins/markets"
            urlComponnent?.queryItems = [
                URLQueryItem(name: "vs_currency", value: "inr"),
                URLQueryItem(name: "sparkline", value: "true"),
                URLQueryItem(name: "price_change_percentage", value: "24h"),
                URLQueryItem(name: "page", value: "\(pageNo)"),
                URLQueryItem(name: "order", value: order)
            ]

        case .getStats:
            urlComponnent?.path = "\(basePath)global"

        }
        guard let queryUrl =  urlComponnent?.url?.absoluteString else {
            throw NetworkError.badURL("Invalid Url")
        }
        return queryUrl
    }
}

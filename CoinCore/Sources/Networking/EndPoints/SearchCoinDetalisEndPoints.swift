//
//  SearchCoinDetalisEndPoints.swift
//
//
//  Created by Abhishek Agarwal on 18/02/22.
//

import Foundation

public enum SearchCoinDetalisEndPoints {

    case search(query: String)
    case getDetails(id: String, localization: String, tickers: Bool, marketData: Bool, communityData: Bool, developerData: Bool, sparkline: Bool)

    var requestTimeOut: Float {
        return 30
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .search, .getDetails:
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
        case .search, .getDetails:
            return nil
        }
    }

  // compose urls for each request
    func getURL(from buildType: BuildType) throws -> String {
        let baseUrl = buildType.commonBaseUrl
        let basePath = "/api/v3/"
        var urlComponnent = URLComponents(string: baseUrl)
        switch self {
        case .search(let query):
            urlComponnent?.path = "\(basePath)search"
            urlComponnent?.queryItems = [ URLQueryItem(name: "query", value: query)]

        case .getDetails(let id, let localization, let tickers, let marketData, let communityData, let developerData, let sparkline):
            urlComponnent?.path = "\(basePath)coins/\(id)"
            urlComponnent?.queryItems = [
            URLQueryItem(name: "localization", value: localization),
            URLQueryItem(name: "tickers", value: "\(tickers)"),
            URLQueryItem(name: "market_data", value: "\(marketData)"),
            URLQueryItem(name: "community_data", value: "\(communityData)"),
            URLQueryItem(name: "developer_data", value: "\(developerData)"),
            URLQueryItem(name: "sparkline", value: "\(sparkline)")
            ]

        }
        guard let queryUrl =  urlComponnent?.url?.absoluteString else {
            throw NetworkError.badURL("Invalid Url")
        }
        return queryUrl
    }
}

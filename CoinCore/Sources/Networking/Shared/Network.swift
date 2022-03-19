//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 18/02/22.
//

import Foundation

public struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod

    public init(url: String,
                headers: [String: String]? = nil,
                reqBody: Encodable? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }

    public init(url: String,
                headers: [String: String]? = nil,
                reqBody: Data? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }

    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL(let message),
                .invalidJSON(let message),
                .noResponse(let message),
                .unableToParseData(let message):
            return NSLocalizedString(message, comment: "Unexpected Error")
        case .apiError(let code, let error),
                .unauthorized(let code, let error),
                .badRequest(let code, let error),
                .serverError(let code, let error),
                .unknown(let code, let error):
            return NSLocalizedString("\(code): \(error)", comment: "Api Error")
        }
    }
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

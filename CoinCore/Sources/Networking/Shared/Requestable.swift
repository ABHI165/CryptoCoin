//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 18/02/22.
//

import Foundation
import Combine

public protocol Requestable {

    var requestTimeout: Float { get }
    func request<T: Codable>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

 public class DefaultRequestable: Requestable {
    public var requestTimeout: Float = 30

    public init () {

    }

    // FIXME: HANDEL URL TIMEOUT
    public func request<T>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError> where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
                sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeout)

        guard let url = URL(string: request.url) else {
                    // Return a fail publisher if the url is invalid
                    return AnyPublisher(
                        Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
                    )
                }
        print(url.absoluteString)
                // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
                return URLSession.shared
                    .dataTaskPublisher(for: request.buildURLRequest(with: url))
                    .subscribe(on: DispatchQueue.global(qos: .utility))
                    .tryMap { output in
                             // throw an error if response is nil
                        guard let response =  output.response as? HTTPURLResponse else {
                            throw NetworkError.serverError(code: 0, error: "Server error")
                        }

                        guard response.statusCode == 200 else {
                            throw NetworkError.apiError(code: response.statusCode, error: response.description)
                        }

                        return output.data
                    }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                               // return error if json decoding fails
                        NetworkError.invalidJSON(String(describing: error))
                    }
                    .eraseToAnyPublisher()
    }

}

//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 20/02/22.
//

import Foundation
import Combine

public typealias Observable<T> = AnyPublisher<T, Error>

public typealias SavedState = CurrentValueSubject<Bool, Never>
public typealias ErrorHandler = PassthroughSubject<Error, Never>

extension Publisher {
     func trackState(_ savedState: SavedState) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            savedState.send(true)
              }, receiveCompletion: { _ in
                  savedState.send(false)
              }).eraseToAnyPublisher()
    }

     func trackError(_ errorTracker: ErrorHandler) -> AnyPublisher<Output, Never> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .catch({ _ in
                 Empty()
             })
        .eraseToAnyPublisher()
    }
}

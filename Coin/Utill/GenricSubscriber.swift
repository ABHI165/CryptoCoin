//
//  GenricSubscriber.swift
//  Coin
//
//  Created by Abhishek Agarwal on 22/02/22.
//

import Combine

struct GenericSubscriber<Value>: Subscriber {
    public var combineIdentifier = CombineIdentifier()
    private let subscribing: (Value) -> Void

    public init<Target: AnyObject>(_ target: Target, onValueReceived:  @escaping (Target, Value) -> Void) {

        weak var weakTarget = target

            self.subscribing = { value in
                if let reference = weakTarget {
                onValueReceived(reference, value)
                }
        }

    }

    public func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }

    public func receive(completion: Subscribers.Completion<Never>) {

    }

    public func receive(_ input: Value) -> Subscribers.Demand {
        subscribing(input)
        return .unlimited
    }

}

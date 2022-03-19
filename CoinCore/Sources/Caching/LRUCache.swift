//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 27/02/22.
//

import Foundation

import UIKit

/// Notification that cache should be cleared
public let LRUCacheMemoryWarningNotification: NSNotification.Name =
    UIApplication.didReceiveMemoryWarningNotification

public final class LRUCache<Key: Hashable, Value> {
    private var values: [Key: Container] = [:]
    private unowned(unsafe) var head: Container?
    private unowned(unsafe) var tail: Container?
    private let lock: NSLock = .init()
    private var token: AnyObject?
    private let notificationCenter: NotificationCenter

    /// The current total cost of values in the cache
    public private(set) var totalCost: Int = 0

    /// The maximum total cost permitted
    public var totalCostLimit: Int {
        didSet { clean() }
    }

    /// The maximum number of values permitted
    public var countLimit: Int {
        didSet { clean() }
    }

    /// Initialize the cache with the specified `totalCostLimit` and `countLimit`
    public init(totalCostLimit: Int = .max, countLimit: Int = .max,
                notificationCenter: NotificationCenter = .default) {
        self.totalCostLimit = totalCostLimit
        self.countLimit = countLimit
        self.notificationCenter = notificationCenter

        self.token = notificationCenter.addObserver(
            forName: LRUCacheMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.removeAllValues()
        }
    }

    deinit {
        if let token = token {
            notificationCenter.removeObserver(token)
        }
    }
}

public extension LRUCache {
    /// The number of values currently stored in the cache
    var count: Int {
        values.count
    }

    /// Is the cache empty?
    var isEmpty: Bool {
        values.isEmpty
    }

    /// Insert a value into the cache with optional `cost`
    func setValue(_ value: Value?, forKey key: Key, cost: Int = 0) {
        guard let value = value else {
            removeValue(forKey: key)
            return
        }
        lock.lock()
        if let container = values[key] {
            container.value = value
            totalCost -= container.cost
            container.cost = cost
            remove(container)
            append(container)
        } else {
            let container = Container(
                value: value,
                cost: cost,
                key: key
            )
            values[key] = container
            append(container)
        }
        totalCost += cost
        lock.unlock()
        clean()
    }

    /// Remove a value  from the cache and return it
    @discardableResult func removeValue(forKey key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        guard let container = values.removeValue(forKey: key) else {
            return nil
        }
        remove(container)
        totalCost -= container.cost
        return container.value
    }

    /// Fetch a value from the cache
    func value(forKey key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        if let container = values[key] {
            remove(container)
            append(container)
            return container.value
        }
        return nil
    }

    /// Remove all values from the cache
    func removeAllValues() {
        lock.lock()
        values.removeAll()
        head = nil
        tail = nil
        lock.unlock()
    }
}

private extension LRUCache {
    final class Container {
        var value: Value
        var cost: Int
        let key: Key
        unowned(unsafe) var prev: Container?
        unowned(unsafe) var next: Container?

        init(value: Value, cost: Int, key: Key) {
            self.value = value
            self.cost = cost
            self.key = key
        }
    }

    // Remove container from list
    func remove(_ container: Container) {
        if head === container {
            head = container.next
        }
        if tail === container {
            tail = container.prev
        }
        container.next?.prev = container.prev
        container.prev?.next = container.next
        container.next = nil
    }

    // Append container to list
    func append(_ container: Container) {
        assert(container.next == nil)
        if head == nil {
            head = container
        }
        container.prev = tail
        tail?.next = container
        tail = container
    }

    func clean() {
        lock.lock()
        defer { lock.unlock() }
        while totalCost > totalCostLimit || count > countLimit,
              let container = head {
            remove(container)
            values.removeValue(forKey: container.key)
            totalCost -= container.cost
        }
    }
}

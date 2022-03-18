//
//  CachedAsyncImage.swift
//  Coin
//
//  Created by Abhishek Agarwal on 14/03/22.
//

import SwiftUI
import Caching

struct CachedAsyncImage<Content: View>: View {
    private let cachingManager: LRUCache<String, Image> = DIContainer.provideCachingManager()
    let url: String
    let scale: CGFloat
    let transaction: Transaction
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    init(url:String, content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = 1
        self.transaction = Transaction()
        self.content = content
    }
    
    init(url:String, scale: CGFloat, transaction: Transaction, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let image = cachingManager.value(forKey: url) {
            content(.success(image))
        }
        else {
            AsyncImage(url: URL(string: url), scale: scale, transaction: transaction) { phase in
                contentViewBuilder(phase: phase)
            }
        }
        
    }
    
    
    private func contentViewBuilder(phase: AsyncImagePhase) -> some View {
        if case let .success(image) = phase {
            cachingManager.setValue(image, forKey: url)
        }
        return content(phase)
    }
}

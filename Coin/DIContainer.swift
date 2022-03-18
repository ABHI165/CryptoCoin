//
//  DIContainer.swift
//  Coin
//
//  Created by Abhishek Agarwal on 24/02/22.
//

import Foundation
import Networking
import Domain
import Data
import Combine
import SwiftUI
import Caching

public class  DIContainer {
    private static let shared = DIContainer()
    
    public static var composeApp: some View {
        return NavigationView {
            CoinListView { cancellableBag in
                DIContainer.shared.provideGetCoinViewModel(cancellableBag: cancellableBag)
            }.navigationBarHidden(true)
        }
    }
    
    private init() {}
    
    private func provideNetworkRequestable() -> Requestable {
        return DefaultRequestable()
    }
    
    private func provideBuidType() -> BuildType {
        return .development
    }
    
    private  func provideGetCoinRepository() -> GetCoinRepo {
        return GetCoinRepoImpl(networkService: provideNetworkRequestable(), buildType: provideBuidType())
    }
    
    private func provideGetCoinUseCase(cancellableBag: CancellableBag) -> GetCoinUseCase {
        return GetCoinUseCase(getcoinRepo: provideGetCoinRepository(),cancellableBag: cancellableBag)
    }
    
    private func provideGetCoinViewModel(cancellableBag: CancellableBag) -> CoinListViewModel {
        return CoinListViewModel(cancellableBag: cancellableBag, getCoinUseCase: provideGetCoinUseCase(cancellableBag: cancellableBag))
    }
    
    static func provideCachingManager<Key: Hashable, Value>() -> LRUCache<Key, Value> {
        return LRUCache<Key, Value>()
    }
    
    
}

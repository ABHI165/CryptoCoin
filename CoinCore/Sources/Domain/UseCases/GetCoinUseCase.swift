//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation
import Combine

public enum LoadingType {
    case loadMore
    case reload
}

public class GetCoinUseCase {
    
    private let getCoinRepo: GetCoinRepo
    
    @Published public var coinData: [CoinModel] = []
    @Published  public var portfolio: [CoinModel] = []
   
    public var isLoadingState = SavedState(false)
    public var isReloadingState = SavedState(false)
    public var errorHandler = ErrorHandler()
    private var cancellableBag: Set<AnyCancellable>
    
    public init(getcoinRepo: GetCoinRepo, cancellableBag: Set<AnyCancellable>){
        self.getCoinRepo = getcoinRepo
        self.cancellableBag = cancellableBag
    }
    
    public func execute(order: String, lodeMoreTriggered: PassthroughSubject<LoadingType,Never>) {
        var isReloading = false
         var pageNo = 1
        lodeMoreTriggered
            .filter({ [weak self] _ in
                guard let self = self else {
                    return false
                }
                print(!self.isLoadingState.value && !self.isReloadingState.value)
              return  !self.isLoadingState.value && !self.isReloadingState.value
            })
            .map{[weak self] (loadingType: LoadingType) -> AnyPublisher<[CoinModel], Never> in
                
                guard let self = self else {
                    return Empty(completeImmediately: true)
                        .eraseToAnyPublisher()
                }
                
                switch loadingType {
                case .loadMore:
                    return self.getCoinRepo.fetchCoinForPage(page: pageNo + 1, order: order)
                        .trackState(self.isLoadingState)
                        .trackError(self.errorHandler)
                        .catch({ _ in
                            Empty()
                        })
                        .eraseToAnyPublisher()
                    
                case .reload:
                    isReloading = true
                    return self.getCoinRepo.fetchCoinForPage(page: pageNo, order: order)
                        .trackState(self.isReloadingState)
                        .trackError(self.errorHandler)
                        .catch({ _ in
                            Empty()
                        })
                        .eraseToAnyPublisher()
                    
                }
            }
            .switchToLatest()
            .sink(receiveValue: {[weak self] (coins:[CoinModel]) in
                if isReloading {
                    isReloading = false
                    self?.coinData.removeAll()
                    self?.coinData.append(contentsOf: coins)
                } else {
                    self?.coinData.append(contentsOf: coins)
                   pageNo += 1
                }
            })
            .store(in: &cancellableBag)
        
           
        
        
        
        
        
    }
}

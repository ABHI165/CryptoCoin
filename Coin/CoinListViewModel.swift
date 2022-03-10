//
//  CoinListViewModel.swift
//  Coin
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation
import Domain
import Combine

public typealias CancellableBag =  Set<AnyCancellable>
public enum MarketCapOrder: String {
    case asc = "market_cap_asc"
    case desc = "market_cap_desc"
}

public final class CoinListViewModel: ObservableObject {
    
    @Published var error = AlertMessage()
    private var cancellableBag: CancellableBag
    @Published var coinData: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    @Published var loadMore = false
    @Published var isReloading = true
    @Published var showPortfolio = false
    private var _isLoadMoreTriggered = PassthroughSubject<LoadingType, Never>()
    
    let getCoinUseCase: GetCoinUseCase
    
    init(cancellableBag: CancellableBag, getCoinUseCase: GetCoinUseCase ) {
        self.getCoinUseCase = getCoinUseCase
        self.cancellableBag = cancellableBag
        addSubscriber()
    }
    
   private func addSubscriber() {
        getCoinUseCase.execute(order: MarketCapOrder.desc.rawValue, lodeMoreTriggered: _isLoadMoreTriggered)
        
        $loadMore
            .combineLatest($isReloading)
            .sink { [weak self] (isLoadMoreTriggered, isReloading) in
                if isLoadMoreTriggered {
                    self?._isLoadMoreTriggered.send(LoadingType.loadMore)
                }
                if isReloading {
                    self?._isLoadMoreTriggered.send(LoadingType.reload)
                }
                
            }.store(in: &cancellableBag)
        
        getCoinUseCase.$coinData
            .sink(receiveValue: { [weak self] coinData in
                self?.coinData.removeAll()
                self?.coinData.append(contentsOf: coinData)
            })
            .store(in: &cancellableBag)
        
        getCoinUseCase.$portfolio
            .sink(receiveValue: { [weak self] coinData in
                self?.portfolio.append(contentsOf: coinData)
            })
            .store(in: &cancellableBag)
        
        getCoinUseCase.errorHandler
            .receive(on: DispatchQueue.main)
            .map{AlertMessage(error: $0)}
            .sink(receiveValue: { [weak self] alertMessage in
                self?.error = alertMessage
            })
            .store(in: &cancellableBag)
        
        getCoinUseCase.isLoadingState
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if !isLoading && self.loadMore {
                    self.loadMore = false }
            }.store(in: &cancellableBag)
        
        getCoinUseCase.isReloadingState
            .sink { [weak self] isReloading in
            guard let self = self else { return }
            if !isReloading && self.isReloading {
                self.isReloading = false
            }
            
        }.store(in: &cancellableBag)
        
        
    }
    
    
}





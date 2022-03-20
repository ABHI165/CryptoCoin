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

    @Published var showError = false
     var error = AlertMessage()
    @Published var loadMore = false
    @Published var isReloading = true
    @Published var showPortfolio = false
    @Published var searchText = ""
    private var cancellableBag: CancellableBag
    @Published var coinData: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    @Published var coinStatsItem: [CoinStatsRowItem] = []
    private var _isLoadMoreTriggered = PassthroughSubject<LoadingType, Never>()

    let getCoinUseCase: GetCoinUseCase
    let getCoinMarketStatsUseCase: GetCoinMarketStatsUseCase

    init(cancellableBag: CancellableBag, getCoinUseCase: GetCoinUseCase, getCoinMarketStatsUseCase: GetCoinMarketStatsUseCase) {
        self.getCoinUseCase = getCoinUseCase
        self.cancellableBag = cancellableBag
        self.getCoinMarketStatsUseCase = getCoinMarketStatsUseCase
        addSubscriber()
    }

    private func addSubscriber() {
        getCoinUseCase.execute(order: MarketCapOrder.desc.rawValue, lodeMoreTriggered: _isLoadMoreTriggered)
        getCoinMarketStatsUseCase.execute()

        getCoinMarketStatsUseCase.$coinStats
            .compactMap {$0}
            .map({ (model) -> [CoinStatsRowItem] in
                var rowItem: [CoinStatsRowItem] = []
                rowItem.append(CoinStatsRowItem(title: "Market Cap", value: model.totalMarketCapInINR.formattedWithAbbreviations(), percentageChange: model.marketCapChangePercentage24HUsd))
                rowItem.append(CoinStatsRowItem(title: "24H Volume", value: model.totalVolumeInINR.formattedWithAbbreviations(), percentageChange: nil))
                rowItem.append(CoinStatsRowItem(title: "BTC Dominance", value: model.btcDominance.asPercentString(), percentageChange: nil))
                rowItem.append(CoinStatsRowItem(title: "Portfolio Value", value: model.btcDominance.asPercentString(), percentageChange: nil))

                return rowItem
            })
            .sink { [weak self] value in
                self?.coinStatsItem = value
            }
            .store(in: &cancellableBag)

        $searchText
            .debounce(for: 0.2, scheduler: DispatchQueue.main, options: nil)
            .combineLatest(getCoinUseCase.$coinData, getCoinUseCase.$portfolio)
            .map { [weak self] (text, coinData, portfolio) -> [CoinModel]? in

                guard let self = self else { return nil }

                if !self.showPortfolio {
                    self.coinData = coinData
                    if text.isEmpty {
                        return self.coinData
                    } else {
                        return self.coinData.filter {$0.name.lowercased().contains(text.lowercased()) || $0.id.lowercased().contains(text.lowercased())}
                    }
                } else {
                    self.portfolio = portfolio
                    if text.isEmpty {
                        return self.portfolio
                    } else {
                        return self.portfolio.filter {$0.name.lowercased().contains(text.lowercased()) || $0.id.lowercased().contains(text.lowercased())}
                    }
                }
            }
            .compactMap {$0}
            .sink { [weak self] model in
                guard let self = self else { return }

                if self.showPortfolio {
                    self.portfolio = model
                } else {
                    self.coinData = model
                }

            }.store(in: &cancellableBag)

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

        getCoinUseCase.errorHandler
            .map {AlertMessage(error: $0)}
            .sink(receiveValue: { [weak self] alertMessage in
                self?.error = alertMessage
                self?.showError = true
            })
            .store(in: &cancellableBag)

        getCoinMarketStatsUseCase.errorHandler
            .map {AlertMessage(error: $0)}
            .sink(receiveValue: { [weak self] alertMessage in
                self?.error = alertMessage
                self?.showError = true
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

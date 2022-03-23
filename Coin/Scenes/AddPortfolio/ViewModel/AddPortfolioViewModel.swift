//
//  AddPortfolioViewModel.swift
//  Coin
//
//  Created by Abhishek Agarwal on 23/03/22.
//

import Foundation
import Domain
import Combine

class AddPortfolioViewModel: ObservableObject {

    @Published var showError = false
    var error = AlertMessage()
    @Published var searchText = ""
    private var cancellableBag: CancellableBag
    @Published var searchedCoin: [SearchedCoinModel]?
    @Published var selectedCoinDetail: CoinDetailsModel?
    @Published var selectedCoin: SearchedCoinModel?

    private let searchCoinUsecase: GetSearchDetailsCoinUseCase

    init(cancellableBag: CancellableBag, getSearchDetailsCoinUseCase: GetSearchDetailsCoinUseCase, getCoinMarketStatsUseCase: GetCoinMarketStatsUseCase) {
        self.searchCoinUsecase = getSearchDetailsCoinUseCase
        self.cancellableBag = cancellableBag
        addSubscriber()
    }

    private func addSubscriber() {
        $searchText
            .debounce(for: 0.6, scheduler: DispatchQueue.main)
            .filter { !$0.isEmpty}
            .sink { [unowned self] coinQuery in
                self.selectedCoin = nil
                self.searchedCoin = nil
                self.selectedCoinDetail = nil
                self.searchCoinUsecase.searchCoin.send(coinQuery)

            }
            .store(in: &cancellableBag)

        searchCoinUsecase.$searchedCoins
            .sink { [weak self] searchedCoins in
                self?.searchedCoin = searchedCoins
            }
            .store(in: &cancellableBag)

        searchCoinUsecase.$coinDetails
            .compactMap {$0}
            .sink { [weak self] (coinDetailsData: CoinDetailsModel) in
                self?.selectedCoinDetail = coinDetailsData
            }
            .store(in: &cancellableBag)

    }
}

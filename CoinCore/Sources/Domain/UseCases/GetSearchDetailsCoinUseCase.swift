//
//  GetSearchCoinUseCase.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

import Foundation
import Combine

public class GetSearchDetailsCoinUseCase {

    @Published public var searchedCoins: [SearchedCoinModel]?
    @Published public var coinDetails: CoinDetailsModel?
    public var errorHandler = ErrorHandler()
    private let searchCoinRepo: SearchCoinDetailsRepo
    private var cancellableBag: Set<AnyCancellable>
    private var coinDetailList: [CoinDetailsModel] = []
    private var searchedCoinsList: [SearchedCoinModel] = []
    public let getCoinDetails = PassthroughSubject<AddPortfolioViewModelInput, Never>()
    public let searchCoin = PassthroughSubject<String, Never>()

    public init(searchCoinRepo: SearchCoinDetailsRepo, cancellableBag: Set<AnyCancellable>) {
        self.searchCoinRepo = searchCoinRepo
        self.cancellableBag = cancellableBag
        addSubscriber()
    }

    private func addSubscriber() {

        searchCoin
            .filter {!$0.isEmpty}
            .map({ [unowned self] (query: String) ->  AnyPublisher<[SearchedCoinModel], Never> in

                let filteredData = searchedCoinsList.filter {$0.name.lowercased().contains(query.lowercased()) || $0.id.lowercased().contains(query.lowercased())}

                if filteredData.isEmpty {
                    return searchCoinRepo.searchCoin(query: query)
                        .trackError(errorHandler)
                        .eraseToAnyPublisher()
                } else {
                    return Just(filteredData)
                        .eraseToAnyPublisher()
                }
            })
            .switchToLatest()
            .sink { [weak self] searchedCoinsData in
                self?.searchedCoinsList.append(contentsOf: searchedCoinsData)
                self?.searchedCoins = searchedCoinsData
            }
            .store(in: &cancellableBag)

        getCoinDetails
            .map {[unowned self] (input) -> AnyPublisher<CoinDetailsModel, Never>in
                let filteredData = self.coinDetailList.filter {$0.name.lowercased().contains(input.name.lowercased()) || $0.id.lowercased().contains(input.id.lowercased())}.first

                if let filteredData = filteredData {
                    return Just(filteredData)
                        .eraseToAnyPublisher()
                } else {
                    return searchCoinRepo.getCoinDetails(id: input.id, localization: input.localization, tickers: input.tickers, marketData: input.marketData, communityData: input.communityData, developerData: input.developerData, sparkline: input.sparkline)
                        .trackError(errorHandler)
                        .eraseToAnyPublisher()

                }

            }
            .switchToLatest()
            .sink { [weak self] models in
                self?.coinDetailList.append(models)
                self?.coinDetails = models
            }
            .store(in: &cancellableBag)

    }
}

extension GetSearchDetailsCoinUseCase {

   public struct AddPortfolioViewModelInput {
        let  id: String,
             localization: String,
             tickers: Bool,
             marketData: Bool,
             communityData: Bool,
             developerData: Bool,
             sparkline: Bool,
             name: String
    }
}

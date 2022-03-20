//
//  GetCoinMarketStats.swift
//  
//
//  Created by Abhishek Agarwal on 20/03/22.
//

import Foundation
import Combine

public class GetCoinMarketStatsUseCase {

    private let getCoinRepo: GetCoinRepo
    private var cancellableBag: Set<AnyCancellable>
    public var errorHandler = ErrorHandler()
    @Published public var coinStats: CoinListStatsModel?

    public init(getcoinRepo: GetCoinRepo, cancellableBag: Set<AnyCancellable>) {
        self.getCoinRepo = getcoinRepo
        self.cancellableBag = cancellableBag
    }

   public func execute() {
        getCoinRepo.getCoinStats()
            .trackError(errorHandler)
            .sink {[weak self] value in
                self?.coinStats = value
            }
            .store(in: &cancellableBag)
    }
}

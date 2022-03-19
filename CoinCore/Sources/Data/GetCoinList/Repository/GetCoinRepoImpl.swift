//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation
import Combine
import Networking
import Domain

public class GetCoinRepoImpl: GetCoinRepo {

    private let networkService: Requestable
    private let buildType: BuildType

    public init (networkService: Requestable, buildType: BuildType) {
        self.networkService = networkService
        self.buildType = buildType
    }

    public func fetchCoinForPage(page: Int, order: String) -> Observable<[CoinModel]> {

        let endPoint = GetCoinsEndpoints.getCoin(page: page, order: order)
        do {
            let request = try endPoint.createRequest(buildType: buildType)
            return networkService.request(request)
                .map { (coin: [CoinDTO]) in
                    coin.map {$0.toCoinModel()}
                }
                .mapError {CustomError.error($0.localizedDescription)}
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        } catch let error {
            return AnyPublisher(Fail<[CoinModel], Error>(error: error ))
        }
    }

    public func getCoinStats() -> Observable<CoinListStats> {
        let endPoint = GetCoinsEndpoints.getStats
        do {
            let request = try endPoint.createRequest(buildType: buildType)
            return networkService.request(request)
                .map { (stats: CoinStatsDTO ) in
                    CoinListStats(totalMarketCap: stats.data.totalMarketCap, totalVolume: stats.data.totalVolume, marketCapPercentage: stats.data.marketCapPercentage, marketCapChangePercentage24HUsd: stats.data.marketCapChangePercentage24HUsd)
                }
                .mapError {CustomError.error($0.localizedDescription)}
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        } catch let error {
            return AnyPublisher(Fail<CoinListStats, Error>(error: error ))
        }
    }

}

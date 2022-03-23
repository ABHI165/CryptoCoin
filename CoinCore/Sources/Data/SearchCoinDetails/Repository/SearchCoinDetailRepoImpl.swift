//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 23/03/22.
//

import Foundation
import Domain
import Networking
import Combine

class SearchCoinDetailRepoImpl: SearchCoinDetailsRepo {

    private let networkService: Requestable
    private let buildType: BuildType

    public init (networkService: Requestable, buildType: BuildType) {
        self.networkService = networkService
        self.buildType = buildType
    }

    func searchCoin( query: String) -> Observable<[SearchedCoinModel]> {
        let endPoint = SearchCoinDetalisEndPoints.search(query: query)
        do {
            let searchRequest = try endPoint.createRequest(buildType: buildType)

            return networkService.request(searchRequest)
                .mapError {CustomError.error($0.localizedDescription)}
                .map { (searchedCoin: SearchCoinDTO) in
                    searchedCoin.toSearchedCoinModel()
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        } catch let error {
            return AnyPublisher(Fail<[SearchedCoinModel], Error>(error: error ))
        }
    }

    func getCoinDetails(id: String, localization: String, tickers: Bool, marketData: Bool, communityData: Bool, developerData: Bool, sparkline: Bool) -> Observable<CoinDetailsModel> {

        let endPoint = SearchCoinDetalisEndPoints.getDetails(id: id, localization: localization, tickers: tickers, marketData: marketData, communityData: communityData, developerData: developerData, sparkline: sparkline)
        do {
            let searchRequest = try endPoint.createRequest(buildType: buildType)

            return networkService.request(searchRequest)
                .mapError {CustomError.error($0.localizedDescription)}
                .map { (coinDetails: CoinDetailsDTO) in
                    coinDetails.toCoinDetailModel()
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()

        } catch let error {
            return AnyPublisher(Fail<CoinDetailsModel, Error>(error: error ))
        }
    }

}

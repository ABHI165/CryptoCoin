//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

public protocol SearchCoinDetailsRepo {

    func searchCoin( query: String) -> Observable<[SearchedCoinModel]>
    func getCoinDetails(id: String, localization: String, tickers: Bool, marketData: Bool, communityData: Bool, developerData: Bool, sparkline: Bool) -> Observable<CoinDetailsModel>

}

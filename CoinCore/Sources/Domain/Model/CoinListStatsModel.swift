//
//  SwiftUIView.swift
//  
//
//  Created by Abhishek Agarwal on 19/03/22.
//

public struct CoinListStatsModel {
     let totalMarketCap,
        totalVolume,
        marketCapPercentage: [String: Double]
    public let marketCapChangePercentage24HUsd: Double

   public init( totalMarketCap: [String: Double], totalVolume: [String: Double], marketCapPercentage: [String: Double], marketCapChangePercentage24HUsd: Double) {
        self.totalVolume = totalVolume
        self.totalMarketCap = totalMarketCap
        self.marketCapPercentage = marketCapPercentage
        self.marketCapChangePercentage24HUsd = marketCapChangePercentage24HUsd
    }

    public var totalMarketCapInINR: Double {
        return totalMarketCap["inr"] ?? 0
    }

    public var totalVolumeInINR: Double {
        return totalVolume["inr"] ?? 0
    }

    public var btcDominance: Double {
        return marketCapPercentage["btc"] ?? 0
    }
}

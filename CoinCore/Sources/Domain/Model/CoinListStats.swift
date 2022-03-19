//
//  SwiftUIView.swift
//  
//
//  Created by Abhishek Agarwal on 19/03/22.
//

public struct CoinListStats {
    let totalMarketCap,
        totalVolume,
        marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

   public init( totalMarketCap: [String: Double], totalVolume: [String: Double], marketCapPercentage: [String: Double], marketCapChangePercentage24HUsd: Double) {
        self.totalVolume = totalVolume
        self.totalMarketCap = totalMarketCap
        self.marketCapPercentage = marketCapPercentage
        self.marketCapChangePercentage24HUsd = marketCapChangePercentage24HUsd
    }
}

//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation

public struct CoinModel: Identifiable, Equatable {
    
    public  let id, symbol, name: String
    public let image: String
    public let currentPrice: Double
    public  let marketCap, marketCapRank, fullyDilutedValuation: Double?
    public let totalVolume, high24H, low24H: Double?
    public let priceChange24H: Double?
    public let priceChangePercentage24H: Double?
    public let marketCapChange24H: Double?
    public let marketCapChangePercentage24H: Double?
    public let circulatingSupply, totalSupply, maxSupply, ath: Double?
    public let athChangePercentage: Double?
    public let athDate: String?
    public let atl, atlChangePercentage: Double?
    public let atlDate: String?
    public let lastUpdated: String?
    public let sparklineIn7D: [Double]?
    public let priceChangePercentage24HInCurrency: Double?
    public let currentHoldings: Double?
    
    public init(id: String, symbol: String, name: String, image: String, currentPrice: Double, marketCap: Double?, marketCapRank: Double?, fullyDilutedValuation: Double?, totalVolume: Double?, high24H: Double?, low24H: Double?, priceChange24H: Double?, priceChangePercentage24H: Double?, marketCapChange24H: Double?, marketCapChangePercentage24H: Double?, circulatingSupply: Double?, totalSupply: Double?, maxSupply: Double?, ath: Double?, athChangePercentage: Double?, athDate: String?, atl: Double?, atlChangePercentage: Double?, atlDate: String?, lastUpdated: String?, sparklineIn7D: [Double]?, priceChangePercentage24HInCurrency: Double?, currentHoldings: Double?) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.totalVolume = totalVolume
        self.high24H = high24H
        self.low24H = low24H
        self.priceChange24H = priceChange24H
        self.priceChangePercentage24H = priceChangePercentage24H
        self.marketCapChange24H = marketCapChange24H
        self.marketCapChangePercentage24H = marketCapChangePercentage24H
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.lastUpdated = lastUpdated
        self.sparklineIn7D = sparklineIn7D
        self.priceChangePercentage24HInCurrency = priceChangePercentage24HInCurrency
        self.currentHoldings = currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
   public var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
   public var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}



//
//  SearchedCoinModel.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

import Foundation

public struct SearchedCoinModel: Identifiable {

    public init(id: String, name: String, symbol: String, marketCapRank: Int, thumb: String, large: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.marketCapRank = marketCapRank
        self.thumb = thumb
        self.large = large
    }

    public  let id,
        name,
        symbol: String
    public let marketCapRank: Int
    public let thumb,
        large: String

}

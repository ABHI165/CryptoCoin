//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

import Foundation
import Domain

// MARK: - Welcome
struct SearchCoinDTO: Codable {
    let coins: [Coin]
    let exchanges: [Exchange]
    let categories: [Category]
    let nfts: [Nft]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}

// MARK: - Coin
struct Coin: Codable {
    let id, name, symbol: String
    let marketCapRank: Int
    let thumb, large: String

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, large
    }
}

// MARK: - Exchange
struct Exchange: Codable {
    let id, name: String
    let marketType: MarketType
    let thumb, large: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case marketType = "market_type"
        case thumb, large
    }
}

enum MarketType: String, Codable {
    case futures = "futures"
    case spot = "spot"
}

// MARK: - Nft
struct Nft: Codable {
    let id: String?
    let name, symbol: String
    let thumb: String
}

extension SearchCoinDTO {
    func toSearchedCoinModel() -> [SearchedCoinModel] {
        return coins.map {SearchedCoinModel(id: $0.id, name: $0.name, symbol: $0.symbol, marketCapRank: $0.marketCapRank, thumb: $0.thumb, large: $0.large)}
    }
}

//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

import Foundation

public struct CoinDetailsModel: Identifiable {

    public init(id: String, symbol: String, name: String, assetPlatformID: String, platforms: PlatformsModel, blockTimeInMinutes: Int, categories: [String?], localization: String, welcomeDescription: String, links: LinksModel, image: String, countryOrigin: String, contractAddress: String, sentimentVotesUpPercentage: Double, sentimentVotesDownPercentage: Double, marketCapRank: Int, coingeckoRank: Int, coingeckoScore: Double, developerScore: Double, communityScore: Double, liquidityScore: Double, publicInterestScore: Double, marketData: MarketDataModel, communityData: CommunityDataModel, developerData: DeveloperDataModel, lastUpdated: String, tickers: [TickerModel]) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.assetPlatformID = assetPlatformID
        self.platforms = platforms
        self.blockTimeInMinutes = blockTimeInMinutes
        self.categories = categories
        self.localization = localization
        self.welcomeDescription = welcomeDescription
        self.links = links
        self.image = image
        self.countryOrigin = countryOrigin
        self.contractAddress = contractAddress
        self.sentimentVotesUpPercentage = sentimentVotesUpPercentage
        self.sentimentVotesDownPercentage = sentimentVotesDownPercentage
        self.marketCapRank = marketCapRank
        self.coingeckoRank = coingeckoRank
        self.coingeckoScore = coingeckoScore
        self.developerScore = developerScore
        self.communityScore = communityScore
        self.liquidityScore = liquidityScore
        self.publicInterestScore = publicInterestScore
        self.marketData = marketData
        self.communityData = communityData
        self.developerData = developerData
        self.lastUpdated = lastUpdated
        self.tickers = tickers
    }

    public let id, symbol, name, assetPlatformID: String
     public let platforms: PlatformsModel
     public let blockTimeInMinutes: Int
     public let categories: [String?]
     public let localization, welcomeDescription: String
     public let links: LinksModel
     public let image: String
     public let countryOrigin: String
     public let contractAddress: String
     public let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double
     public let marketCapRank, coingeckoRank: Int
     public let coingeckoScore, developerScore, communityScore, liquidityScore: Double
     public let publicInterestScore: Double
     public let marketData: MarketDataModel
     public let communityData: CommunityDataModel
     public let developerData: DeveloperDataModel
     public let lastUpdated: String
     public let tickers: [TickerModel]

}

// MARK: - CommunityData
public struct CommunityDataModel: Identifiable {
    public init(twitterFollowers: Int, redditAveragePosts48H: Int, redditAverageComments48H: Double, redditSubscribers: Int, redditAccountsActive48H: Int, telegramChannelUserCount: Int) {
        self.twitterFollowers = twitterFollowers
        self.redditAveragePosts48H = redditAveragePosts48H
        self.redditAverageComments48H = redditAverageComments48H
        self.redditSubscribers = redditSubscribers
        self.redditAccountsActive48H = redditAccountsActive48H
        self.telegramChannelUserCount = telegramChannelUserCount
    }

     public let id = UUID().uuidString
     public let twitterFollowers, redditAveragePosts48H: Int
    public let redditAverageComments48H: Double
    public let redditSubscribers, redditAccountsActive48H, telegramChannelUserCount: Int

}

// MARK: - DeveloperData
public struct DeveloperDataModel: Identifiable {
    public init(forks: Int, stars: Int, subscribers: Int, totalIssues: Int, closedIssues: Int, pullRequestsMerged: Int, pullRequestContributors: Int, commitCount4_Weeks: Int, last4_WeeksCommitActivitySeries: [Int]) {
        self.forks = forks
        self.stars = stars
        self.subscribers = subscribers
        self.totalIssues = totalIssues
        self.closedIssues = closedIssues
        self.pullRequestsMerged = pullRequestsMerged
        self.pullRequestContributors = pullRequestContributors
        self.commitCount4_Weeks = commitCount4_Weeks
        self.last4_WeeksCommitActivitySeries = last4_WeeksCommitActivitySeries
    }

    public let id = UUID().uuidString
    public let forks, stars, subscribers, totalIssues: Int
    public let closedIssues, pullRequestsMerged, pullRequestContributors: Int
    public let commitCount4_Weeks: Int
    public let last4_WeeksCommitActivitySeries: [Int]

}

// MARK: - Links
public struct LinksModel: Identifiable {
    public init(homepage: [String], blockchainSite: [String], officialForumURL: [String], chatURL: [String], announcementURL: [String], twitterScreenName: String, facebookUsername: String, telegramChannelIdentifier: String, subredditURL: String, reposURL: ReposURLModel) {
        self.homepage = homepage
        self.blockchainSite = blockchainSite
        self.officialForumURL = officialForumURL
        self.chatURL = chatURL
        self.announcementURL = announcementURL
        self.twitterScreenName = twitterScreenName
        self.facebookUsername = facebookUsername
        self.telegramChannelIdentifier = telegramChannelIdentifier
        self.subredditURL = subredditURL
        self.reposURL = reposURL
    }

    public let id = UUID().uuidString

    public let homepage, blockchainSite: [String]
    public let officialForumURL, chatURL: [String]
    public let announcementURL: [String]
    public let twitterScreenName, facebookUsername: String
    public let telegramChannelIdentifier: String
    public let subredditURL: String
    public let reposURL: ReposURLModel
}

// MARK: - ReposURL
public struct ReposURLModel: Identifiable {
    public init(github: [String], bitbucket: [String]) {
        self.github = github
        self.bitbucket = bitbucket
    }

    public let id = UUID().uuidString

    public let github: [String]
    public let bitbucket: [String]
}

// MARK: - MarketData
public struct MarketDataModel: Identifiable {
    public init(currentPrice: [String: Double], marketCap: [String: Double], marketCapRank: Int, fullyDilutedValuation: [String: Double], totalVolume: [String: Double], high24H: [String: Double], low24H: [String: Double], priceChange24H: Double, priceChangePercentage24H: Double, priceChangePercentage7D: Double, priceChangePercentage14D: Double, priceChangePercentage30D: Double, priceChangePercentage60D: Double, priceChangePercentage200D: Double, priceChangePercentage1Y: Int, marketCapChange24H: Int, marketCapChangePercentage24H: Double, priceChange24HInCurrency: [String: Double], priceChangePercentage1HInCurrency: [String: Double], priceChangePercentage24HInCurrency: [String: Double], priceChangePercentage7DInCurrency: [String: Double], priceChangePercentage14DInCurrency: [String: Double], priceChangePercentage30DInCurrency: [String: Double], priceChangePercentage60DInCurrency: [String: Double], priceChangePercentage200DInCurrency: [String: Double], marketCapChange24HInCurrency: [String: Double], marketCapChangePercentage24HInCurrency: [String: Double], totalSupply: Int, maxSupply: Int, circulatingSupply: Int, sparkline7D: Sparkline7DModel) {
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.totalVolume = totalVolume
        self.high24H = high24H
        self.low24H = low24H
        self.priceChange24H = priceChange24H
        self.priceChangePercentage24H = priceChangePercentage24H
        self.priceChangePercentage7D = priceChangePercentage7D
        self.priceChangePercentage14D = priceChangePercentage14D
        self.priceChangePercentage30D = priceChangePercentage30D
        self.priceChangePercentage60D = priceChangePercentage60D
        self.priceChangePercentage200D = priceChangePercentage200D
        self.priceChangePercentage1Y = priceChangePercentage1Y
        self.marketCapChange24H = marketCapChange24H
        self.marketCapChangePercentage24H = marketCapChangePercentage24H
        self.priceChange24HInCurrency = priceChange24HInCurrency
        self.priceChangePercentage1HInCurrency = priceChangePercentage1HInCurrency
        self.priceChangePercentage24HInCurrency = priceChangePercentage24HInCurrency
        self.priceChangePercentage7DInCurrency = priceChangePercentage7DInCurrency
        self.priceChangePercentage14DInCurrency = priceChangePercentage14DInCurrency
        self.priceChangePercentage30DInCurrency = priceChangePercentage30DInCurrency
        self.priceChangePercentage60DInCurrency = priceChangePercentage60DInCurrency
        self.priceChangePercentage200DInCurrency = priceChangePercentage200DInCurrency
        self.marketCapChange24HInCurrency = marketCapChange24HInCurrency
        self.marketCapChangePercentage24HInCurrency = marketCapChangePercentage24HInCurrency
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.circulatingSupply = circulatingSupply
        self.sparkline7D = sparkline7D
    }

    public let id = UUID().uuidString

    public let currentPrice: [String: Double]
    public let marketCap: [String: Double]
    public let marketCapRank: Int
    public let fullyDilutedValuation, totalVolume, high24H, low24H: [String: Double]
    public let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double
    public let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D: Double
    public let priceChangePercentage1Y, marketCapChange24H: Int
    public let marketCapChangePercentage24H: Double
    public let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]
    public let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]
    public let marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]
    public let totalSupply, maxSupply, circulatingSupply: Int
    public let sparkline7D: Sparkline7DModel

}

// MARK: - Sparkline7D
public struct Sparkline7DModel: Identifiable {
    public init(price: [Double]) {
        self.price = price
    }

    public let id = UUID().uuidString

    public let price: [Double]
}

// MARK: - Platforms
public struct PlatformsModel: Identifiable {
    public init(moonriver: String, meter: String) {
        self.moonriver = moonriver
        self.meter = meter
    }

    public let id = UUID().uuidString
    public let moonriver, meter: String
}

// MARK: - Ticker
public struct TickerModel: Identifiable {
    public init(base: String, target: String, market: MarketModel, last: Double, volume: Double, convertedLast: [String: Double], convertedVolume: [String: Double], bidAskSpreadPercentage: Double, timestamp: Date, lastTradedAt: Date, lastFetchAt: Date, isAnomaly: Bool, isStale: Bool, tradeURL: String, coinID: String, targetCoinID: String?) {
        self.base = base
        self.target = target
        self.market = market
        self.last = last
        self.volume = volume
        self.convertedLast = convertedLast
        self.convertedVolume = convertedVolume
        self.bidAskSpreadPercentage = bidAskSpreadPercentage
        self.timestamp = timestamp
        self.lastTradedAt = lastTradedAt
        self.lastFetchAt = lastFetchAt
        self.isAnomaly = isAnomaly
        self.isStale = isStale
        self.tradeURL = tradeURL
        self.coinID = coinID
        self.targetCoinID = targetCoinID
    }

    public let id = UUID().uuidString
    public let base, target: String
    public let market: MarketModel
    public let last, volume: Double
    public let convertedLast, convertedVolume: [String: Double]
    public let bidAskSpreadPercentage: Double
    public let timestamp, lastTradedAt, lastFetchAt: Date
    public let isAnomaly, isStale: Bool
    public let tradeURL: String
    public let coinID: String
    public let targetCoinID: String?
}

// MARK: - Market
public struct MarketModel: Identifiable {
    public init(name: String, identifier: String, hasTradingIncentive: Bool) {
        self.name = name
        self.identifier = identifier
        self.hasTradingIncentive = hasTradingIncentive
    }

    public let id = UUID().uuidString
    public let name, identifier: String
    public let hasTradingIncentive: Bool

}

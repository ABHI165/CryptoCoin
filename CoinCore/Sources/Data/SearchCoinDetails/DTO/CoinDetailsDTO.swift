//
//  CoinDetailsDTO.swift
//  
//
//  Created by Abhishek Agarwal on 22/03/22.
//

import Foundation
import Domain
import CloudKit

// MARK: - Welcome
struct CoinDetailsDTO: Codable {
    let id, symbol, name, assetPlatformID: String
    let platforms: Platforms
    let blockTimeInMinutes: Int
    let categories: [String?]
    let localization, welcomeDescription: Tion
    let links: Links
    let image: Image
    let countryOrigin: String
    let contractAddress: String
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double
    let marketCapRank, coingeckoRank: Int
    let coingeckoScore, developerScore, communityScore, liquidityScore: Double
    let publicInterestScore: Double
    let marketData: MarketData
    let communityData: CommunityData
    let developerData: DeveloperData
    let lastUpdated: String
    let tickers: [Ticker]

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case assetPlatformID = "asset_platform_id"
        case platforms
        case blockTimeInMinutes = "block_time_in_minutes"
        case categories
        case localization
        case welcomeDescription = "description"
        case links, image
        case countryOrigin = "country_origin"
        case contractAddress = "contract_address"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case coingeckoScore = "coingecko_score"
        case developerScore = "developer_score"
        case communityScore = "community_score"
        case liquidityScore = "liquidity_score"
        case publicInterestScore = "public_interest_score"
        case marketData = "market_data"
        case communityData = "community_data"
        case developerData = "developer_data"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - CommunityData
struct CommunityData: Codable {
    let twitterFollowers, redditAveragePosts48H: Int
    let redditAverageComments48H: Double
    let redditSubscribers, redditAccountsActive48H, telegramChannelUserCount: Int

    enum CodingKeys: String, CodingKey {
        case twitterFollowers = "twitter_followers"
        case redditAveragePosts48H = "reddit_average_posts_48h"
        case redditAverageComments48H = "reddit_average_comments_48h"
        case redditSubscribers = "reddit_subscribers"
        case redditAccountsActive48H = "reddit_accounts_active_48h"
        case telegramChannelUserCount = "telegram_channel_user_count"
    }
}

// MARK: - DeveloperData
struct DeveloperData: Codable {
    let forks, stars, subscribers, totalIssues: Int
    let closedIssues, pullRequestsMerged, pullRequestContributors: Int
    let codeAdditionsDeletions4_Weeks: CodeAdditionsDeletions4_Weeks
    let commitCount4_Weeks: Int
    let last4_WeeksCommitActivitySeries: [Int]

    enum CodingKeys: String, CodingKey {
        case forks, stars, subscribers
        case totalIssues = "total_issues"
        case closedIssues = "closed_issues"
        case pullRequestsMerged = "pull_requests_merged"
        case pullRequestContributors = "pull_request_contributors"
        case codeAdditionsDeletions4_Weeks = "code_additions_deletions_4_weeks"
        case commitCount4_Weeks = "commit_count_4_weeks"
        case last4_WeeksCommitActivitySeries = "last_4_weeks_commit_activity_series"
    }
}

// MARK: - CodeAdditionsDeletions4_Weeks
struct CodeAdditionsDeletions4_Weeks: Codable {
    let additions, deletions: Int
}

// MARK: - Image
struct Image: Codable {
    let thumb, small, large: String
}

// MARK: - Links
struct Links: Codable {
    let homepage, blockchainSite: [String]
    let officialForumURL, chatURL: [String]
    let announcementURL: [String]
    let twitterScreenName, facebookUsername: String
    let telegramChannelIdentifier: String
    let subredditURL: String
    let reposURL: ReposURL

    enum CodingKeys: String, CodingKey {
        case homepage
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
    }
}

// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]
    let bitbucket: [String]
}

// MARK: - Tion
struct Tion: Codable {
    let en, de, es, fr: String
    let it, pl, ro, hu: String
    let nl, pt, sv, vi: String
    let tr, ru, ja, zh: String
    let zhTw, ko, ar, th: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: [String: Double]
    let ath, athChangePercentage: [String: Double]
    let athDate: [String: String]
    let atl, atlChangePercentage: [String: Double]
    let atlDate: [String: String]
    let marketCap: [String: Double]
    let marketCapRank: Int
    let fullyDilutedValuation, totalVolume, high24H, low24H: [String: Double]
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D: Double
    let priceChangePercentage1Y, marketCapChange24H: Int
    let marketCapChangePercentage24H: Double
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]
    let priceChangePercentage1YInCurrency: PriceChangePercentage1YInCurrency
    let marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]
    let totalSupply, maxSupply, circulatingSupply: Int
    let sparkline7D: Sparkline7D
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case sparkline7D = "sparkline_7d"
        case lastUpdated = "last_updated"
    }
}

// MARK: - PriceChangePercentage1YInCurrency
struct PriceChangePercentage1YInCurrency: Codable {
}

// MARK: - Sparkline7D
struct Sparkline7D: Codable {
    let price: [Double]
}

// MARK: - Platforms
struct Platforms: Codable {
    let moonriver, meter: String
}

// MARK: - Ticker
struct Ticker: Codable {
    let base, target: String
    let market: Market
    let last, volume: Double
    let convertedLast, convertedVolume: [String: Double]
    let trustScore: TrustScore?
    let bidAskSpreadPercentage: Double
    let timestamp, lastTradedAt, lastFetchAt: Date
    let isAnomaly, isStale: Bool
    let tradeURL: String
    let coinID: String
    let targetCoinID: String?

    enum CodingKeys: String, CodingKey {
        case base, target, market, last, volume
        case convertedLast = "converted_last"
        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeURL = "trade_url"
        case coinID = "coin_id"
        case targetCoinID = "target_coin_id"
    }
}

// MARK: - Market
struct Market: Codable {
    let name, identifier: String
    let hasTradingIncentive: Bool

    enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
    }
}

enum TrustScore: String, Codable {
    case green = "green"
    case yellow = "yellow"
}

extension CoinDetailsDTO {

    func toCoinDetailModel() -> CoinDetailsModel {

        let platforms = PlatformsModel(moonriver: platforms.moonriver, meter: platforms.meter)

        let links = LinksModel(homepage: links.homepage, blockchainSite: links.blockchainSite, officialForumURL: links.officialForumURL, chatURL: links.chatURL, announcementURL: links.announcementURL, twitterScreenName: links.twitterScreenName, facebookUsername: links.facebookUsername, telegramChannelIdentifier: links.twitterScreenName, subredditURL: links.subredditURL, reposURL: ReposURLModel(github: links.reposURL.github, bitbucket: links.reposURL.bitbucket))

        let marketData = MarketDataModel(currentPrice: marketData.currentPrice, marketCap: marketData.marketCap, marketCapRank: marketData.marketCapRank, fullyDilutedValuation: marketData.fullyDilutedValuation, totalVolume: marketData.totalVolume, high24H: marketData.high24H, low24H: marketData.low24H, priceChange24H: marketData.priceChange24H, priceChangePercentage24H: marketData.priceChangePercentage24H, priceChangePercentage7D: marketData.priceChangePercentage7D, priceChangePercentage14D: marketData.priceChangePercentage14D, priceChangePercentage30D: marketData.priceChangePercentage30D, priceChangePercentage60D: marketData.priceChangePercentage60D, priceChangePercentage200D: marketData.priceChangePercentage200D, priceChangePercentage1Y: marketData.priceChangePercentage1Y, marketCapChange24H: marketData.marketCapChange24H, marketCapChangePercentage24H: marketData.priceChangePercentage24H, priceChange24HInCurrency: marketData.priceChange24HInCurrency, priceChangePercentage1HInCurrency: marketData.priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency: marketData.priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: marketData.priceChangePercentage7DInCurrency, priceChangePercentage14DInCurrency: marketData.priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency: marketData.priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency: marketData.priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: marketData.priceChangePercentage200DInCurrency, marketCapChange24HInCurrency: marketData.marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: marketData.marketCapChangePercentage24HInCurrency, totalSupply: marketData.totalSupply, maxSupply: marketData.maxSupply, circulatingSupply: marketData.circulatingSupply, sparkline7D: Sparkline7DModel(price: marketData.sparkline7D.price))

        let communityData = CommunityDataModel(twitterFollowers: communityData.twitterFollowers, redditAveragePosts48H: communityData.redditAveragePosts48H, redditAverageComments48H: communityData.redditAverageComments48H, redditSubscribers: communityData.redditSubscribers, redditAccountsActive48H: communityData.redditAccountsActive48H, telegramChannelUserCount: communityData.telegramChannelUserCount)

        let developerData  = DeveloperDataModel(forks: developerData.forks, stars: developerData.stars, subscribers: developerData.subscribers, totalIssues: developerData.totalIssues, closedIssues: developerData.closedIssues, pullRequestsMerged: developerData.pullRequestsMerged, pullRequestContributors: developerData.pullRequestContributors, commitCount4_Weeks: developerData.commitCount4_Weeks, last4_WeeksCommitActivitySeries: developerData.last4_WeeksCommitActivitySeries)

        var tickersModel: [TickerModel] = []

        tickers.forEach { ticker in
            tickersModel.append(TickerModel(base: ticker.base, target: ticker.target, market: MarketModel(name: ticker.market.name, identifier: ticker.market.identifier, hasTradingIncentive: ticker.market.hasTradingIncentive), last: ticker.last, volume: ticker.volume, convertedLast: ticker.convertedLast, convertedVolume: ticker.convertedVolume, bidAskSpreadPercentage: ticker.bidAskSpreadPercentage, timestamp: ticker.timestamp, lastTradedAt: ticker.lastTradedAt, lastFetchAt: ticker.lastFetchAt, isAnomaly: ticker.isAnomaly, isStale: ticker.isStale, tradeURL: ticker.tradeURL, coinID: ticker.coinID, targetCoinID: ticker.targetCoinID))
        }

        return CoinDetailsModel(id: self.id, symbol: symbol, name: name, assetPlatformID: assetPlatformID, platforms: platforms, blockTimeInMinutes: blockTimeInMinutes, categories: categories, localization: localization.en, welcomeDescription: welcomeDescription.en, links: links, image: image.thumb, countryOrigin: countryOrigin, contractAddress: contractAddress, sentimentVotesUpPercentage: sentimentVotesUpPercentage, sentimentVotesDownPercentage: sentimentVotesUpPercentage, marketCapRank: marketCapRank, coingeckoRank: coingeckoRank, coingeckoScore: coingeckoScore, developerScore: developerScore, communityScore: communityScore, liquidityScore: liquidityScore, publicInterestScore: publicInterestScore, marketData: marketData, communityData: communityData, developerData: developerData, lastUpdated: lastUpdated, tickers: tickersModel)

    }
}

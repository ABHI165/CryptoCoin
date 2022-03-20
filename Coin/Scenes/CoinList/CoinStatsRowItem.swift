//
//  CoinStatsRowItem.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/03/22.
//

import SwiftUI

struct CoinStatsRowItem: Identifiable {
    let title: String
    let value: String
    let percentageChange: Double?
    let id = UUID().uuidString
}

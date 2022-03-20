//
//  CoinStatsRow.swift
//  Coin
//
//  Created by Abhishek Agarwal on 19/03/22.
//

import SwiftUI

struct CoinStatsColumnView: View {
    let data: CoinStatsRowItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(data.title)
                .font(.subheadline)
                .foregroundColor(.primary.accent)

            Text(data.value)
                .font(.subheadline)
                .foregroundColor(.primary.secondaryText)

            HStack(spacing: 2) {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect((data.percentageChange ?? 0) > 0 ? Angle(degrees: 0) : Angle(degrees: 180))

                Text((data.percentageChange ?? 0).asPercentString())
                    .font(.subheadline)

            }
            .foregroundColor((data.percentageChange ?? 0) > 0 ? Color.primary.green : Color.primary.red)
            .opacity(data.percentageChange == nil ? 0 : 1)
        }
    }
}

struct CoinStatsColumn_Provider: PreviewProvider {
    static var previews: some View {

        Group {
            CoinStatsColumnView(data: CoinStatsRowItem(title: "Market", value: "$44545 Tr", percentageChange: nil))

            CoinStatsColumnView(data: CoinStatsRowItem(title: "Market", value: "$44545 Tr", percentageChange: 45.7))

            CoinStatsColumnView(data: CoinStatsRowItem(title: "Market", value: "$44545 Tr", percentageChange: -45.7))

        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}

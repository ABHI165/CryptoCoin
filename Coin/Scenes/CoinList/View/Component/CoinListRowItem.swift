//
//  CoinListRowItem.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/02/22.
//

import SwiftUI
import Domain

struct CoinListRowItem: View {
    let coinModel: CoinModel
    let showHolding: Bool

    var body: some View {

        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHolding {
                holdingColumn
            }
            rightColumn
        }
        .background(Color.primary.background)
        .font(.caption)
    }
}

// MARK: - Extension View
extension CoinListRowItem {

    @ViewBuilder
    private func getImageFromPhase(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFit()
        case .failure(let error):
           // debugPrint("Something Went Wrong \(error)")
            ProgressView()
        @unknown default:
            ProgressView()
        }
    }

    // MARK: Left Column
    private var leftColumn: some View {
        HStack(spacing: 5) {
            Text("\(coinModel.rank)")
                .font(.subheadline)
                .foregroundColor(Color.primary.secondaryText)

            CachedAsyncImage(url: coinModel.image) { phase in
                getImageFromPhase(phase)
            }.clipShape(Circle())

            Text("\(coinModel.symbol.uppercased())")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
    }

    // MARK: Right Column
    private var rightColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(coinModel.currentPrice.asCurrencyWith6Decimals())")
                .font(.subheadline)
                .foregroundColor(.white)

            Text(coinModel.priceChangePercentage24H?.asPercentString() ?? "0.0%")
                .font(.subheadline)
                .bold()
                .foregroundColor(
                    coinModel.priceChangePercentage24H ?? 0 >= 0 ? Color.primary.green : Color.primary.red
                )

        }.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }

    // MARK: Holding Column
    private var holdingColumn: some View {
        VStack(spacing: 0) {
            Text("\(coinModel.currentHoldingsValue.asCurrencyWith2Decimals())")
                .font(.subheadline)
                .foregroundColor(.white)
                .bold()

            Text(coinModel.currentHoldings?.asNumberString() ?? "0.0")
                .font(.subheadline)
                .foregroundColor(Color.primary.secondaryText)

        }

    }
}

// MARK: - Preview Provider
struct CoinListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinListRowItem(coinModel: dev.coin, showHolding: false)
                .previewLayout(.sizeThatFits)

            CoinListRowItem(coinModel: dev.coin, showHolding: true)
                .previewLayout(.sizeThatFits)
        }

    }
}

//
//  CoinSelectorView.swift
//  Coin
//
//  Created by Abhishek Agarwal on 21/03/22.
//

import SwiftUI

struct CoinSelectorView: View {
    @Binding var isSelected: Bool
    let url: String
    var body: some View {

        VStack {
            CachedAsyncImage(url: url) { imagePhase in
                getImageFromPhase(imagePhase)
            }
            .frame(width: 150, height: 150)

            Text("BTC")
                .font(.headline)
                .bold()
                .foregroundColor(.primary.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Text("BTC")
                .font(.subheadline)
                .foregroundColor(.primary.secondaryText)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(isSelected ? Color.primary.red : .clear, lineWidth: 3)

        }

    }

    @ViewBuilder
    private func getImageFromPhase(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.primary.accent)
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
        case .failure(let error):
            // debugPrint("Something Went Wrong \(error)")
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.primary.accent)
        @unknown default:
            ProgressView()
        }
    }
}

struct CoinSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSelectorView(isSelected: .constant(true), url: "https://assets.coingecko.com/coins/images/17984/small/9285.png?1630028620")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}

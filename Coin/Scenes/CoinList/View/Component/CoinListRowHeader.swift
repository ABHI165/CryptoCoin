//
//  CoinListRowHeader.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/02/22.
//

import SwiftUI

struct CoinListRowHeader: View {
    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            Text("Coin")
                .foregroundColor(Color.primary.secondaryText)
            Spacer()
            if showPortfolio {
                Text("Holding")
                    .foregroundColor(Color.primary.secondaryText)
                    .animation(.easeInOut)
            }

            Text("Price")
                .foregroundColor(Color.primary.secondaryText)
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .background(Color.primary.background)
    }
}

struct CoinListRowHeader_Previews: PreviewProvider {
    static var previews: some View {
        CoinListRowHeader(showPortfolio: .constant(true))
    }
}

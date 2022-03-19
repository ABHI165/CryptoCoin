//
//  ContentView.swift
//  Coin
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CoinListViewModel()
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .onTapGesture {
                    vm.getCoinsForPage(page: 1, order: "market_cap_desc")
                }

            if let ty = vm.coinData {
                Text(ty[0].name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CoinListView.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/02/22.
//

import SwiftUI

struct CoinListView: View {
    @StateObject private var homeVm: CoinListViewModel
    @State var showAddPortfolioView = false
    private var cancellableBag = CancellableBag()

    init(initializer: @escaping (CancellableBag) -> CoinListViewModel) {
        let vm = initializer(cancellableBag)
        self._homeVm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        ZStack {
            Color.primary.background.ignoresSafeArea()

            VStack(spacing: 0) {
               headerView
                statsView

                SearchBar(text: $homeVm.searchText)

                CoinListRowHeader(showPortfolio: $homeVm.showPortfolio)
                    .padding()
                Spacer()
                if homeVm.showPortfolio {
                    portfolioCoinView
                        .transition(.move(edge: .trailing))
                }

                if !homeVm.showPortfolio {
                    cryptoCoinView
                            .transition(.move(edge: .leading))
                }

            }

            ErrorSnackBar(isPresented: $homeVm.showError, error: homeVm.error)
                .ignoresSafeArea(.all)
        }

    }

}

// struct CoinListView_Preview: PreviewProvider {
//    static var previews: some View {
////        NavigationView {
////            CoinListView { cancellableBag in
////                DIContainer.provideGetCoinViewModel(cancellableBag: cancellableBag)
////            }
////        }
//    }
// }

// MARK: - Extension
extension CoinListView {
    private var statsView: some View {
        HStack {
            ForEach(homeVm.coinStatsItem) { data in
                CoinStatsColumnView(data: data)
                    .frame(width: UIScreen.main.bounds.width/3 )
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: homeVm.showPortfolio ? .trailing : .leading)

    }

    private var headerView: some View {
            HStack(alignment: .center) {
                CircularButton(animate: $homeVm.showPortfolio, imageName: homeVm.showPortfolio ? "plus" : "info") {
                    if homeVm.showPortfolio {
                       showAddPortfolioView = true
                    }

                }
                .padding()
                .sheet(isPresented: $showAddPortfolioView) {
                    AddPortfolioView()
                }
                Spacer()

                Text(homeVm.showPortfolio ? "Portfolio" : "Live Price")
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .animation(.linear)

                Spacer()

                CircularButton(imageName: "chevron.right") {
                    withAnimation(.spring()) {
                        homeVm.showPortfolio.toggle()
                    }

                }
                .padding()
                .rotationEffect(homeVm.showPortfolio ? Angle(degrees: 180) : .zero)

            }
            .frame(height: 76)
            .background(Color.primary.background)
    }

    private var cryptoCoinView: some View {

        List {

            ForEach(homeVm.coinData) { model in
                CoinListRowItem(coinModel: model, showHolding: false)
                    .onAppear(perform: {
                      if let lastData = homeVm.coinData.last, model == lastData {
                            homeVm.loadMore = true
                        }
                    })
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
            }.listRowBackground(Color.primary.background)
        }
        .refreshable {
            homeVm.isReloading = true
        }
        .listStyle(PlainListStyle())

    }

    private var portfolioCoinView: some View {
        List {
            ForEach(homeVm.portfolio) { model in
                CoinListRowItem(coinModel: model, showHolding: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            .listRowBackground(Color.primary.background)

        }
        .listStyle(PlainListStyle())

    }
}

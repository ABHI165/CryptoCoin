//
//  AddPortfolioView.swift
//  Coin
//
//  Created by Abhishek Agarwal on 21/03/22.
//

import SwiftUI

struct AddPortfolioView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color.primary.background.ignoresSafeArea()
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {

                        }
                    }

                }

            }
            .navigationTitle("Edit Portfolio")
            .foregroundColor(.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CircularButton(imageName: "xmark") {
                          dismiss()
                    }
                    .padding(.top)
                }
            }

        }

    }
}

struct AddPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolioView()
    }
}

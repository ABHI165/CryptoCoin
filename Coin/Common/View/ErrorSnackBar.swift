//
//  ErrorSnackBar.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/03/22.
//

import SwiftUI

struct ErrorSnackBar: View {
    @Binding var isPresented: Bool
    let error: AlertMessage
    let delay: Double = 5

    var body: some View {
        let currentOffset = isPresented ? UIScreen.main.bounds.height * 0.4 : 10000
        let opacity = isPresented ? 1.0 : 0.0

       getBottomSnackBar()
        .offset(y: currentOffset)
        .opacity(opacity)
        .transition(AnyTransition.slide)
        .animation(.easeIn(duration: 3), value: currentOffset)
    }

    func getBottomSnackBar() -> some View {
        if isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                isPresented = false
            }
        }

        return  HStack(alignment: .center, spacing: 5) {
            LottieView(name: "error-animation", loopMode: .loop)
                .frame(width: 50, height: 50)
                .padding(.leading)

            Text(error.message)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.trailing)

        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: 100, alignment: .leading)
        .background {
            ZStack {
                //                RoundedRectangle(cornerRadius: 22, style: .continuous)
                //                    .fill(Color.primary.accent.opacity(0.1))

                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
        }

    }
}

struct ErrorSnackBar_Previews: PreviewProvider {
    static var previews: some View {
        ErrorSnackBar(isPresented: .constant(true), error: AlertMessage())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

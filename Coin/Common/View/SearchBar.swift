//
//  SearchBar.swift
//  Coin
//
//  Created by Abhishek Agarwal on 18/03/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        ZStack {
            let xOffset: CGFloat = text.isEmpty ? -48 : -70
            let yOffset: CGFloat = text.isEmpty ? 0 : -24
            Text("Search by name or symbol...")
                .font(text.isEmpty ? .subheadline : .caption)
                .foregroundColor(Color.primary.secondaryText)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.primary.background)
                }
                .offset(x: xOffset)
                .offset(y: yOffset)
                .zIndex(text.isEmpty ? 0 : 1)
                .animation(Animation.easeIn(duration: 0.1), value: yOffset)
                .animation(Animation.easeIn(duration: 0.1), value: xOffset)

            HStack {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .font(.caption)
                    .foregroundColor(
                        text.isEmpty ? Color.white : Color.primary.accent
                    )

                TextField("", text: $text)
                    .foregroundColor(Color.white)
                    .disableAutocorrection(true)

                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .font(.caption)
                    .foregroundColor(
                        text.isEmpty ? Color.white : Color.primary.accent
                    )
                    .opacity(text.isEmpty ? 0 : 1)
                    .onTapGesture {
                        text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }

            }
            .background {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(text.isEmpty ? Color.primary.secondaryText : Color.primary.accent, lineWidth: 1)
                    .shadow(color: .white.opacity(0.6), radius: 1, x: -1, y: -2)
                    .shadow(color: .black, radius: 1, x: 5, y: 6)

        }
        .padding()

        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primary.background
            SearchBar(text: .constant(""))
        }

           // .preferredColorScheme(.dark)
    }
}

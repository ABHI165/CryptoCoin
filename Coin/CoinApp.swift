//
//  CoinApp.swift
//  Coin
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import SwiftUI

@main
struct CoinApp: App {

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primary.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.primary.accent)]
    }

    var body: some Scene {
        WindowGroup {
            DIContainer.composeApp
        }
    }
}

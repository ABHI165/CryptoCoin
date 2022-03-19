//
//  AlertMessage.swift
//  Coin
//
//  Created by Abhishek Agarwal on 22/02/22.
//

import Foundation

struct AlertMessage {
    let message: String
    let title: String

    init(error: Error) {
        self.title = "Opps! Someting Went Wrong."
        self.message = error.localizedDescription
    }

    init() {
        self.message = ""
        self.title = ""
    }
}

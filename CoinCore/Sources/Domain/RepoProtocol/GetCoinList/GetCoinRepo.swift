//
//  File.swift
//  
//
//  Created by Abhishek Agarwal on 19/02/22.
//

import Foundation
import Combine

public protocol GetCoinRepo {
    
    func fetchCoinForPage(page: Int, order: String) -> Observable<[CoinModel]>
}

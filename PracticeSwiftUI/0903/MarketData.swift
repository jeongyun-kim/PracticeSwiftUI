//
//  MarketData.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import Foundation

struct MarketData: Identifiable {
    let id = UUID()
    let name: String
    let market: String
    var isLike: Bool
    
    init(name: String, market: String) {
        self.name = name
        self.market = market
        self.isLike = false
    }
}

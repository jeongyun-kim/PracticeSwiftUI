//
//  CoinDetailView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import SwiftUI

struct CoinDetailView: View {
    var market: Market
    
    var body: some View {
        Text(market.koreanName)
            .font(.title)
            .bold()
            .toolbarRole(.editor)
    }
}

#Preview {
    CoinDetailView(market: Market(market: "", koreanName: "비트코인", englishName: ""))
}

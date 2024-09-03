//
//  CoinView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import SwiftUI

struct CoinView: View {
    @State private var keyword = ""
    @State private var markets: [Market] = []
    @State private var banner = Banner()
    @State private var market = Market(market: "String", koreanName: "", englishName: "")
    private var filteredMarkets: [Market] {
        return keyword.isEmpty ? markets : markets.filter { $0.koreanName.contains(keyword) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                bannerView(market, banner: banner)
                marketListView()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("My Money")
            .searchable(text: $keyword, prompt: "마켓을 검색해보세요")
        }
        .task {
            NetworkService.shared.fetchData { result in
                switch result {
                case .success(let value):
                    markets = value
                    guard let randomMarket = value.randomElement() else { return }
                    market = randomMarket
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
   
}

extension CoinView {
    func marketListView() -> some View {
        LazyVStack {
            ForEach(filteredMarkets, id: \.self) { item in
                NavigationLink {
                    CoinDetailView(market: item)
                } label: {
                    marketDataView(item)
                }
                .tint(.black)
            }
        }
    }
    
    func bannerView(_ data: Market, banner: Banner) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(banner.color) // 색 채우기
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(.white.opacity(0.25))
                        .scaleEffect(2)
                        .offset(x: -35) // x 좌표 이동
                }
            // RoundedRectangle에 맞춰서 잘라줘
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(height: 160) // 사이즈 지정
            
            VStack(alignment: .leading) {
                Spacer()
                Text(data.market)
                    .font(.callout)
                Text("\(data.koreanName) | \(data.englishName)")
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .padding(.horizontal)
    }
    
    func marketDataView(_ data: Market) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.koreanName)
                    .font(.title2)
                    .bold()
                Text(data.market)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(data.englishName)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    CoinView()
}

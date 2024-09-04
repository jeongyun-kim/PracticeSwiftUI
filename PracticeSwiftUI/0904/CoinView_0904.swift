//
//  CoinView_0904.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/4/24.
//

import SwiftUI

struct CoinView_0904: View {
    @State private var keyword = ""
    @State private var markets: [Market] = []
    @State private var banner = Banner()
    @State private var market = Market(market: "", koreanName: "", englishName: "")
    @State private var filteredMarkets: [Market] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                bannerView(market, banner: banner)
                marketListView()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("My Money")
            .searchable(text: $keyword, prompt: "마켓을 검색해보세요")
            .onSubmit(of: .search) { // 검색버튼 탭
                filteredMarkets = markets.filter { $0.koreanName.contains(keyword) }
            }
        }
        .task {
            NetworkService.shared.fetchData { result in
                switch result {
                case .success(let value):
                    markets = value
                    filteredMarkets = value
                    guard let randomMarket = value.randomElement() else { return }
                    market = randomMarket
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
   
}

extension CoinView_0904 {
    func marketListView() -> some View {
        LazyVStack {
            // binding된 데이터를 보내기 위해 $ 표시
            ForEach($filteredMarkets, id: \.self) { $item in
                NavigationLink {
                    // NaviagationLazyView로 감싸줘서 상세뷰 불러오기
                    NavigationLazyView(CoinDetailView(market: item))
                } label: {
                    MarketDataView(item: $item)
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
}

struct MarketDataView: View {
    // 좋아요 반영을 위한 binding 데이터 받아오기
    @Binding var item: Market
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.koreanName)
                    .font(.title2)
                    .bold()
                Text(item.market)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(item.englishName)
            Button(action: {
                item.isLike.toggle()
            }, label: {
                let image = item.isLike ? "star.fill" : "star"
                Image(systemName: image)
            })
            .frame(width: 40, height: 40)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    CoinView_0904()
}

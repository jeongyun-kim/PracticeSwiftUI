//
//  SearchView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import SwiftUI

struct SearchView: View {
    @State private var list: [MarketData] = []
    @State private var filteredList: [MarketData] = []
    @State private var itemData = MarketData(name: "", market: "")
    @State private var keyword = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                configureListView()
            }
            .searchable(text: $keyword, prompt: "마켓을 검색해보세요")
            .onSubmit(of: .search) {
                // 검색버튼 눌러서 데이터 받아오기
                // - 대소문자 구분없이
                filteredList = list.filter { $0.name.lowercased().contains(keyword.lowercased()) }
            }
            .navigationTitle("Search")
        }
        .task { // 뷰 뜨면 네트워크 통신
            NetworkService.shared.fetchData { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    list = value.map { MarketData(name: $0.englishName, market: $0.market) }
                }
            }
        }
    }
    
    func configureListView() -> some View {
        ForEach(filteredList, id: \.id) { item in
            LazyVStack {
                marketView(item)
            }
        }
    }
    
    func marketView(_ item: MarketData) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .foregroundStyle(.yellow)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title3)
                Text(item.market)
            }
            Spacer()
            // 좋아요 처리
            Button(action: {
                guard let idx = list.firstIndex(where: { data in
                    data.id == item.id
                }) else { return }
                list[idx].isLike.toggle()
                filteredList = list.filter { $0.name.lowercased().contains(keyword.lowercased()) }
            }, label: {
                let isLike = item.isLike
                Image(systemName: isLike ? "star.fill" : "star")
                    .tint(.black)
            })
            .frame(width: 40, height: 40)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    SearchView()
}

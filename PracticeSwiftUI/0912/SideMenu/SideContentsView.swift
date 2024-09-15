//
//  SideContentsView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/15/24.
//

import SwiftUI

struct SideContentsView: View {
    enum Menus: Int, CaseIterable {
        case search = 0
        // case filter
        case setting
        
        var title: String {
            switch self {
            case .search:
                return "검색"
            case .setting:
                return "설정"
            }
        }
        
        var imageName: String {
            switch self {
            case .search:
                return "magnifyingglass"
            case .setting:
                return "gearshape.fill"
            }
        }
    }
    
    // 선택한 사이드메뉴 콘텐츠
    @Binding var selectedSideMenu: Int
    // 사이드메뉴의 표출 여부
    @Binding var isPresenting: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                logView()
                ForEach(Menus.allCases, id: \.self) { item in
                    rowView(item)
                }
                Spacer()
            }
            .padding(.top, 80)
            .padding(32)
            .frame(maxHeight: .infinity)
            .background(Color(hex: 0xfcecc7, opacity: 1))
            Spacer()
        }
        .background(.clear)
    }
    
    // 기록한 팝업 개수 표출
    private func logView() -> some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text("✏️ 지금까지의 기록")
                .font(.title2)
            Text("5개")
                .font(.title)
                .bold()
        }
        .padding(.vertical, 24)
    }
    
    // 페이지 이동 버튼
    private func rowView(_ item: Menus) -> some View {
        NavigationLink {
            ContentView()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: item.imageName)
                    .resizable()
                    .frame(width: 26, height: 26)
                Text(item.title)
                    .font(.title3)
                    .bold()
            }
            .padding(.vertical)
            .padding(.trailing, 100)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    SideContentsView(selectedSideMenu: .constant(0), isPresenting: .constant(true))
}

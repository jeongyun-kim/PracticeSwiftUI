//
//  RandomImageView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/5/24.
//

import SwiftUI

struct RandomImageView: View {
    @State var sectionTitle = [
        "첫번째 섹션",
        "두번째 섹션",
        "세번째 섹션"
    ]
    
    var body: some View {
        NavigationWrapper {
            ScrollView {
                LazyVStack {
                    ForEach($sectionTitle, id: \.self) { $item in
                        SectionView(title: $item)
                    }
                }
            }
            .navigationTitle("My Random Image")
        }
    }
}

struct SectionView: View {
    @Binding var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
            HorizontalImageStackView(title: $title)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

private struct HorizontalImageStackView: View {
    @Binding var title: String
        
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(0..<6) { item in
                    let url = URL(string: "https://picsum.photos/id/\(Int.random(in: 1...20))/200/300")
                    // 이미지 누르면 상세보기 뷰로 이동
                    NavigationLink {
                        let view = RandomImageDetailView(title: $title, url: url)
                        NavigationLazyView(view)
                    } label: {
                        makeRoundedImageView(url: url)
                    }
                }
            }
        }
    }
}


#Preview {
    RandomImageView()
}

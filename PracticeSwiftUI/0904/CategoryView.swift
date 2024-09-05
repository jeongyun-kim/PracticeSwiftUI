//
//  CategoryView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/5/24.
//

import SwiftUI

struct Genre: Identifiable {
    let id = UUID()
    let category: String
    let cnt = Int.random(in: 1...100)
    
    var desc: String {
        return "\(category)(\(cnt))"
    }
}

struct CategoryView: View {
    @State var keyword = ""
    @State var genreList: [Genre] = []
    private let genre = ["로맨스", "스릴러", "애니메이션", "공포", "SF", "가족", "코믹"]
    
    var body: some View {
        NavigationWrapper {
            GenreListView()
            .navigationTitle("영화 장르 리스트")
            .searchable(text: $keyword, prompt: "영화를 검색해보세요")
            .navigationBar {
                
            } trailing: {
                configureTrailing()
            }
            
        }
    }
    
    private func configureTrailing() -> some View {
        Button(action: {
            guard let randomGenre = genre.randomElement() else { return }
            let data = Genre(category: randomGenre)
            genreList.append(data)
        }, label: {
            Text("추가")
        })
    }
    
    private func GenreListView() -> some View {
        List {
            ForEach(genreList, id: \.id) { item in
                NavigationLink {
                    NavigationLazyView(CategoryDetailView())
                } label: {
                    HStack {
                        Image(systemName: "person")
                        Text(item.desc)
                    }
                }

            }
        }
    }
}

#Preview {
    CategoryView()
}

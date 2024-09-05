//
//  RoundedImageView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/5/24.
//

import SwiftUI

private struct RoundedImageView: ViewModifier {
    let url: URL?
    let width: CGFloat
    let heigh: CGFloat
    private let errorImage = "xmark"
    
    func body(content: Content) -> some View {
        // 비동기로 이미지 가져오기
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                // 이미지 로드하고 있는 상황 -> 로딩
                ProgressView()
                    .frame(width: width, height: heigh)
            case .success(let image):
                // 이미지 가져오기 성공
                image
                    .resizable()
                    .frame(width: width, height: heigh)
                    .clipShape(.buttonBorder)
            case .failure(_):
                // 이미지 가져오기 실패
                Image(systemName: errorImage)
                    .frame(width: width, height: heigh)
            @unknown default:
                Image(systemName: errorImage)
                    .frame(width: width, height: heigh)
            }
        }
    }
}

extension View {
    func makeRoundedImageView(url: URL?, width: CGFloat = 150, height: CGFloat = 200) -> some View {
        modifier(RoundedImageView(url: url, width: width, heigh: height))
    }
}

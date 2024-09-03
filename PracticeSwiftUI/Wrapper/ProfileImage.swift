//
//  ProfileImage.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

private struct ProfileImage: ViewModifier {
    let imageName: String
    let size: CGFloat
    
    func body(content: Content) -> some View {
        Image(imageName, bundle: nil)
            .resizable() // 이미지 사이즈 맞추게
            .clipShape(.circle) // 둥글게
            .frame(width: size, height: size, alignment: .center) // frame
            .overlay(Circle().stroke(Color.blue, lineWidth: 5)) // 위에 border 추가
    }
}

extension View {
    func asProfileImage(imageName: String, size: CGFloat) -> some View {
        modifier(ProfileImage(imageName: imageName, size: size))
    }
}

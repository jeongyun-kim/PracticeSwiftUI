//
//  ProfileSettingView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

struct ProfileSettingView: View {
    @State private var nickname = ""
    @State private var isPresented = false
    let estj = ["E", "S", "T", "J"]
    let infp = ["I", "N", "F", "P"]
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                NavigationLink(destination: {
                    ProfileImageSettingView()
                }, label: {
                    randomProfileImage()
                })
                nicknameTextField()
                mbtiView()
                Spacer()
                Button("완료") {
                    isPresented = true
                }
                .asNextButton()
                .fullScreenCover(isPresented: $isPresented, content: {
                    CompleteView()
                })
                
            }
            .padding(.top)
            .navigationTitle("PROFILE SETTING")
            .toolbarRole(.editor)
        }
       
    }
    
    func mbtiView() -> some View {
        HStack(alignment: .top, spacing: 36) {
            Text("MBTI")
                .font(.title2)
                .bold()
            VStack {
                mbtiButtonView(estj)
                mbtiButtonView(infp)
            }
        }
        .padding(.horizontal, 24)
    }
    
    func mbtiButtonView(_ data: [String]) -> some View {
        HStack(spacing: 6) {
            ForEach(data, id: \.self) { item in
                asMBTIButton(item)
            }
        }
    }
    
    func randomProfileImage() -> some View {
        let randomNumber = Int.random(in: 0...11)
        let imageName = "profile_\(randomNumber)"
        let size: CGFloat = 120
        return asProfileImage(imageName: imageName, size: size)
    }
    
    func nicknameTextField() -> some View {
        VStack(spacing: 8) {
            TextField("닉네임을 입력해보세요 :)", text: $nickname)
            asCustomBorder()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ProfileSettingView()
}

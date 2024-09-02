//
//  ContentView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Image("launch", bundle: nil)
                Image("launchImage", bundle: nil)
                Spacer()
                NavigationLink("시작하기") {
                    ProfileSettingView()
                }
                .asNextButton()
            }
            
        }
    }
}

#Preview {
    ContentView()
}

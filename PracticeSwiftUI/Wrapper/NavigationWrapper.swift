//
//  NavigationWrapper.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/4/24.
//

import SwiftUI

// 네비게이션 형태 iOS16 기준으로 NavigationView / NavigationStack
struct NavigationWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
}

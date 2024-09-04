//
//  NavigationLazyView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/4/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    // 보여줄 뷰에 대한 데이터를 가지고 있고
    let build: () -> Content
    
    // body가 그려질 때, 가지고 있던 뷰 그리기
    var body: some View {
        // 누가들어와도 괜찮은 Generic
        build()
    }
    
    // autoclosure: closure를 좀 더 간편하게 쓰고싶을 때 {} 대신 ()내부에 삽입할 수 있게 
    init(_ build: @autoclosure @escaping () -> Content) {
        print("navigationlazy view init")
        self.build = build
    }
}

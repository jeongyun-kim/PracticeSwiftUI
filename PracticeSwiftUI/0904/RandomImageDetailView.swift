//
//  RandomImageDetailView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/5/24.
//

import SwiftUI

struct RandomImageDetailView: View {
    @Binding var title: String
    var url: URL?
    var sendNewTitle: ((String) -> Void)?
    
    var body: some View {
        VStack(alignment: .center, content: {
            makeRoundedImageView(url: url, width: 300, height: 400)
            TextField("섹션명을 입력해보세요", text: $title)
                .multilineTextAlignment(.center)
               
        })
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    RandomImageDetailView(title: .constant("dd"), url: nil)
}

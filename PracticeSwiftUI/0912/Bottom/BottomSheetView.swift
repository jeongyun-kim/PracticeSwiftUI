//
//  BottomSheetView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/13/24.
//

import SwiftUI

struct BottomSheetView: View {
    var body: some View {
        VStack {
            Text("Dd")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(hex: 0xFFE382, opacity: 0.2))
        //.background(Color(hex: 0xFDEEDC, opacity: 1))
        //.background(Color(hex: 0xFEFBE9, opacity: 0.5))
        //.background(Color(hex: 0xFFEEA9, opacity: 0.4))
    }
}

#Preview {
    BottomSheetView()
}

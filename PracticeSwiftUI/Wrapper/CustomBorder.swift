//
//  CustomBorder.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

private struct CustomBorder: ViewModifier {
    func body(content: Content) -> some View {
        Divider()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .background(Color.black.opacity(0.1))
    }
}

extension View {
    func asCustomBorder() -> some View {
        modifier(CustomBorder())
    }
}

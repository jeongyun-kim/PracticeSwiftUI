//
//  NextButton.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

private struct NextButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(.blue)
            .foregroundStyle(.white)
            .bold()
            .clipShape(.capsule)
            .padding()
    }
}

extension View {
    func asNextButton() -> some View {
        return modifier(NextButton())
    }
}

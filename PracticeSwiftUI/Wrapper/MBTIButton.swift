//
//  MBTIButton.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/2/24.
//

import SwiftUI

private struct MBTIButton: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        Button(action: {
            print("tap")
        }, label: {
            Text(title)
                .font(.title2)
                .frame(width: 20, height: 20, alignment: .center)
                .padding()
                .clipShape(.circle)
                .overlay(Circle().stroke(lineWidth: 1))
                .foregroundStyle(.gray)
        })
    }
}

extension View {
    func asMBTIButton(_ title: String) -> some View {
        modifier(MBTIButton(title: title))
    }
}

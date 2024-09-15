//
//  SideMenuView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/15/24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isPresenting: Bool
    var content: AnyView
    
    var body: some View {
            ZStack{
                if isPresenting {
                    Color.black
                        .opacity(0.3)
                        .onTapGesture {
                            isPresenting.toggle()
                        }
                    content
                        .transition(.move(edge: .leading))
                        .background(.clear)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut, value: isPresenting)
            
            
    }
}

#Preview {
    SideMenuView(isPresenting: .constant(true), content: AnyView(SideContentsView(selectedSideMenu: .constant(0), isPresenting: .constant(true))))
}

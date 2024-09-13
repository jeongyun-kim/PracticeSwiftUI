//
//  MainTabView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/14/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var showSheet = true
    
//    init() {
//        UITabBar.appearance().backgroundColor = .white
//        UITabBar.appearance().tintColor = .brown
//    }
    var body: some View {
        TabView {
            FSCalendarView()
                .tabItem { Image(systemName: "calendar") }
                .onAppear {
                    showSheet = true
                    
//                    UITabBar.appearance().backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.51, alpha: 0.2)
                }
                
            Text("ABC")
                .tabItem { Image(systemName: "calendar") }
                .task {
                    showSheet = false
                }
        }
//        .background(Color(hex: 0xFFE382, opacity: 0.2))
        .toolbarBackground(.red, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .sheet(isPresented: $showSheet) {
            BottomSheetView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .presentationDetents([.fraction(0.3), .fraction(0.75)])
            .presentationCornerRadius(42)
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled()
            
            .bottomMasksForSheet()
        }
        
    }
}

#Preview {
    MainTabView()
}

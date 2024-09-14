//
//  MainTabView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/14/24.
//

import SwiftUI

struct MainTabView: View {
    enum SelectedTab: String, Hashable {
        case calendar
        case setting
    }
    @State private var showSheet = true
    @State private var selectedTab: SelectedTab = .calendar
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.51, alpha: 0.2)
      
    }
    var body: some View {
        TabView {
        
            FSCalendarView()
                .tabItem { Image(systemName: "calendar") }
                .onAppear {
                    showSheet = true
                }
             
            ScrollView { }
                .tabItem { Image(systemName: "magnifyingglass") }
                .task {
                    showSheet = false
                }
            
            ScrollView { }
                .tabItem { Image(systemName: "gearshape") }
                .task {
                    showSheet = false
                }
            
        }

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

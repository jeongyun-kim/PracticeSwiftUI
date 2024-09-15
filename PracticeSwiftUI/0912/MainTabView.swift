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
    @State var selectedSideMenuTab: Int = 0
    @State var presentSideMenu: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedSideMenuTab,
                    content:  {
               // FSCalendarView(isPresentingSheet: $showSheet, presentSideMenu: $presentSideMenu)
               
            })
            SideMenuView(isPresenting: $presentSideMenu, content: AnyView(SideContentsView(selectedSideMenu: $selectedSideMenuTab, isPresenting: $presentSideMenu)))
           
        }
    }
}

#Preview {
    MainTabView()
}

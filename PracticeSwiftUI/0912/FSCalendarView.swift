//
//  FSCalendarView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import SwiftUI


enum Detents: CaseIterable {
    case mid
    case large
    
    var detents: PresentationDetent {
        switch self {
        case .mid:
            return .fraction(0.3)
        case .large:
            return .fraction(0.7)
        }
    }
}

struct FSCalendarView: View {
    @StateObject var vm = CalendarViewModel()
   // @Binding var isPresentingSheet: Bool
    @State private var isLarge: PresentationDetent = Detents.mid.detents
    @State private var isAppearing = true
   // @Binding var presentSideMenu: Bool
    @State var isPresentingSheet = true
   
    @State var selectedSideMenuTab: Int = 0
    @State var presentSideMenu: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(vm.output.currentDate)
                            .font(.callout)
                            .foregroundStyle(.gray.opacity(0.8))
                            .padding(.horizontal)
                            .padding(.top, 16)
                            .padding(.bottom, 4)
                        
                        Text("✨ 오늘은 어떤 팝업을 다녀오셨나요?")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        
                        
                        FSCalendarViewControllerWrapper(vm: vm, modalMode: $isLarge)
                            .frame(height: (proxy.size.width-32))
                            .padding(.horizontal)
                            .sheet(isPresented: $isPresentingSheet, content: {
                                BottomSheetView()
                                    .presentationDetents([Detents.mid.detents, Detents.large.detents], selection: $isLarge)
                                    .presentationBackgroundInteraction(.enabled)
                                    .presentationDragIndicator(.hidden)
                                    .presentationCornerRadius(42)
                                    .interactiveDismissDisabled()
                            })
                    }
                    
                }
                SideMenuView(isPresenting: $presentSideMenu, content: AnyView(SideContentsView(selectedSideMenu: $selectedSideMenuTab, isPresenting: $presentSideMenu)))
                    .onChange(of: presentSideMenu) {
                        guard isAppearing else { return }
                        // 사이드메뉴 열리면 아래뷰는 내리고 닫히면 아래뷰 올리기
                        isPresentingSheet = !presentSideMenu
                    }
            }
            .onDisappear {
                isAppearing = false
                
            }
            .onAppear {
                guard !isAppearing else { return }
                isAppearing = true
                presentSideMenu = false
            }
            .navigationBar {
                Button(action: {
                    // 사이드메뉴 열기
                    presentSideMenu.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .tint(Color(hex: 0xFF8911))
                })
            } trailing: {
                Text("")
            }
        }
    }
    
}

#Preview {
    FSCalendarView()
    //MainTabView()
    //FSCalendarView(presentSideMenu: .constant(true))
}

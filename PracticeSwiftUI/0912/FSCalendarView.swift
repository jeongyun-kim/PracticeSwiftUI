//
//  FSCalendarView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import SwiftUI

struct FSCalendarView: View {
    enum Detents {
        static let mid: PresentationDetent = .fraction(0.3)
        static let large: PresentationDetent = .fraction(0.7)
        
        
    }
    
    @StateObject private var vm = CalendarViewModel.shared
    @State private var isPresenting = true
    @State private var selectedDetent: PresentationDetent = .fraction(0.3)
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: 8) {
                    Text("2024년 9월")
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
                    
                    FSCalendarViewControllerWrapper()
                        .frame(height: proxy.size.height * 0.55)
                        .padding(.horizontal)
                    
                        .sheet(isPresented: $isPresenting, content: {
                            BottomSheetView()
                                .presentationDetents([.fraction(0.3), .fraction(0.7)], selection: $selectedDetent)
                                .presentationBackgroundInteraction(.enabled)
                                .presentationDragIndicator(.hidden)
                                .presentationCornerRadius(32)
                                .interactiveDismissDisabled()
                        })
                        
                
                }
           
                
            }
        }
        
    }
}

#Preview {
    FSCalendarView()
}

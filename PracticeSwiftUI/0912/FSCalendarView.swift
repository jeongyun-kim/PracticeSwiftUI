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
    @State private var isPresenting = true
    @State private var isLarge: PresentationDetent = Detents.mid.detents
    
   
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                
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
                                                    .sheet(isPresented: $isPresenting, content: {
                                                        BottomSheetView()
                                                            .presentationDetents([Detents.mid.detents, Detents.large.detents], selection: $isLarge)
                                                            .presentationBackgroundInteraction(.enabled)
                                                            .presentationDragIndicator(.hidden)
                                                            .presentationCornerRadius(42)
                                                            .interactiveDismissDisabled()
                                                    })
                        
                     
                    }
                    
                
            }
            .navigationBar {
                Button(action: {
                    
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
}

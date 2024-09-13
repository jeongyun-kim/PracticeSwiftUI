//
//  FSCalendarView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import SwiftUI


struct FSCalendarView: View {
    @StateObject var vm = CalendarViewModel()
    @State private var isPresenting = true
    
    enum Detents {
        case mid
        case large
        
        var detents: PresentationDetent {
            switch self {
            case .mid:
                return .fraction(0.4)
            case .large:
                return .fraction(0.75)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
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
                        
                        
                        FSCalendarViewControllerWrapper(vm: vm)
                            .frame(height: (proxy.size.width-32))
                            .padding(.horizontal)
//                            .sheet(isPresented: $isPresenting, content: {
//                                BottomSheetView()
//                                    .presentationDetents([Detents.mid.detents, Detents.large.detents])
//                                    .presentationBackgroundInteraction(.enabled)
//                                    .presentationDragIndicator(.hidden)
//                                    .presentationCornerRadius(42)
//                                    .interactiveDismissDisabled()
//                            })
                    }
                    
                }
            }
        }
        
        
        //
        //

    }
}

#Preview {
    FSCalendarView()
}

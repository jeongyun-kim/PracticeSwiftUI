//
//  FSCalendarView.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import SwiftUI

struct FSCalendarView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("2024년 9월")
                        .font(.title3)
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(.horizontal)
                        .padding(.top, 16)
                    Text("✨ 오늘은 어떤 팝업을 다녀오셨나요?")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    FSCalendarViewControllerWrapper()
                        .frame(height: UIScreen.main.bounds.width)
                        .padding(.horizontal)
                    
                    Button(action: {
                        
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                }
               
            }
        }
        
    }
}

#Preview {
    FSCalendarView()
}

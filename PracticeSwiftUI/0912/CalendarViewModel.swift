//
//  CalendarViewModel.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/13/24.
//

import Foundation
import Combine

final class CalendarViewModel: ObservableObject {
    static let shared = CalendarViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    enum InputAction {
        case selectedDate(date: Date?)
    }
    
    func action(_ action: InputAction) {
        switch action {
        case .selectedDate(let today):
            input.selectedDate.send(today)
        }
    }
    
    struct Input {
        let selectedDate = CurrentValueSubject<Date?, Never>(nil)
       // @State private var selectedDetent: PresentationDetent = .fraction(0.3)
    }
    
    struct Output {
        var selectedDate = Date()
    }
    
    init() {
        input.selectedDate
            .sink { value in
                guard let value else { return }
                self.output.selectedDate = value
                print(self.output.selectedDate)
            }.store(in: &subscriptions)
    }
}

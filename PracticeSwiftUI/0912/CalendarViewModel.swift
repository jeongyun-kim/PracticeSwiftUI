//
//  CalendarViewModel.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/13/24.
//

import Foundation
import Combine

final class CalendarViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    enum InputAction {
        case selectedDate(date: Date?)
        case currentDate(year: Int?, month: Int?)
    }
    
    func action(_ action: InputAction) {
        switch action {
        case .selectedDate(let today):
            input.selectedDate.send(today)
        case .currentDate(let year, let month):
            input.currentPageDate.send([year, month])
        }
    }
    
    struct Input {
        let selectedDate = CurrentValueSubject<Date?, Never>(nil)
        let currentPageDate = PassthroughSubject<[Int?], Never>()
    }
    
    struct Output {
        var selectedDate = Date()
        var currentDate = ""
    }
    
    init() {
        input.selectedDate
            .sink { value in
                guard let value else { return }
                self.output.selectedDate = value
            }.store(in: &subscriptions)
        
        input.currentPageDate
            .sink { [weak self] value in
                guard let self else { return }
                guard let year = value[0], let month = value[1] else { return }
                self.output.currentDate = "\(year)년 \(month)월"
            }.store(in: &subscriptions)
       
    }
}

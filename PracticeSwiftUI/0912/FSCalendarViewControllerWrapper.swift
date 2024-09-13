//
//  FSCalendarViewControllerWrapper.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import UIKit
import SwiftUI
import Combine
import FSCalendar
import SnapKit

struct FSCalendarViewControllerWrapper: UIViewControllerRepresentable {
    @ObservedObject var vm: CalendarViewModel
    
    func makeUIViewController(context: Context) -> some UIViewController {
        FSCalendarViewController(vm: vm)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class FSCalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
        init(vm: CalendarViewModel) {
            super.init(nibName: nil, bundle: nil)
            self.vm = vm
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var vm: CalendarViewModel!
        private var subscriptions = Set<AnyCancellable>()
        
        private lazy var calendar: FSCalendar = {
            let calendar = FSCalendar()
            calendar.delegate = self
            calendar.dataSource = self
            calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
            calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
            calendar.appearance.weekdayTextColor = .black
            calendar.appearance.titleFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            calendar.appearance.titleSelectionColor = .white
            calendar.appearance.todayColor = UIColor(red: 1.00, green: 0.54, blue: 0.07, alpha: 1.00) 
            calendar.appearance.headerMinimumDissolvedAlpha = 0.0
            calendar.appearance.selectionColor = UIColor(red: 1.00, green: 0.54, blue: 0.07, alpha: 1.00)
            calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14)
            calendar.appearance.borderRadius = 0.5
            calendar.headerHeight = 0
            calendar.placeholderType = .none
            return calendar
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupHierarchy()
            setupConstraints()
            sendDatas()
        }
        
        private func setupHierarchy() {
            view.addSubview(calendar)
        }
        
        private func setupConstraints() {
            calendar.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            guard let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: date, at: position) as? CalendarCell else { return FSCalendarCell() }
            cell.configureCell(date == vm.output.selectedDate)
            return cell
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            calendar.today = date
            vm.action(.selectedDate(date: date))
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            sendDate()
        }
        
        private func sendDatas() {
            vm.action(.selectedDate(date: calendar.today))
            sendDate()
            
        }
        
        private func sendDate() {
            let date = Calendar.current.dateComponents([.month, .year], from: calendar.currentPage)
            let year = date.year
            let month = date.month
            vm.action(.currentDate(year: year, month: month))
        }
    }
}

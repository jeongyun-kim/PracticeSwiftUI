//
//  FSCalendarViewControllerWrapper.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import UIKit
import SwiftUI
import FSCalendar
import SnapKit

struct FSCalendarViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        FSCalendarViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class FSCalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
        var vm: CalendarViewModel = CalendarViewModel.shared
      
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
            calendar.headerHeight = 0
            calendar.placeholderType = .none
            return calendar
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupHierarchy()
            setupConstraints()
            vm.action(.selectedDate(date: calendar.today))
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
            cell.configureCell(date == calendar.today)
            return cell
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            guard let preCell = calendar.cell(for: vm.output.selectedDate, at: monthPosition) as? CalendarCell else { return }
            preCell.configureCell(false)
            
            calendar.today = date
            guard let todayCell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else { return }
            todayCell.configureCell(true)
            vm.action(.selectedDate(date: date))
        }
    }
}

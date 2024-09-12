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
        private var selectedCell: CalendarCell? = nil
        
        private lazy var calendar: FSCalendar = {
            let calendar = FSCalendar()
            calendar.delegate = self
            calendar.dataSource = self
            calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
            calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
            calendar.placeholderType = .none
            calendar.appearance.weekdayTextColor = .black
            calendar.appearance.titleFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            calendar.appearance.titleSelectionColor = .white
            calendar.appearance.todayColor = UIColor(red: 0.99, green: 0.75, blue: 0.38, alpha: 1.00) //UIColor(red: 0.99, green: 0.75, blue: 0.38, alpha: 1.00)
            calendar.appearance.headerMinimumDissolvedAlpha = 0.0
            calendar.appearance.selectionColor = UIColor(red: 0.99, green: 0.75, blue: 0.38, alpha: 1.00) //UIColor(red: 0.99, green: 0.75, blue: 0.38, alpha: 1.00)
            calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14)
            calendar.headerHeight = 0
            return calendar
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupHierarchy()
            setupConstraints()
            //view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.66, alpha: 0.1)
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
            cell.configureCell()
            return cell
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            calendar.today = date
            guard let cell = calendar.cell(for: date, at: monthPosition) as? CalendarCell else { return }
            cell.thumbImageView.layer.opacity = 0.1
        
        }
    }
}

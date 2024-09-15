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
    @Binding var modalMode: PresentationDetent

    func makeUIViewController(context: Context) -> some UIViewController {
        FSCalendarViewController(vm: vm)
    }
    
    // 뷰컨 업데이트 => mid면 월간달력 / large면 주간달력
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let detents = Detents.allCases.map { $0.detents }
        guard let type = detents.filter({ $0 == modalMode }).first else { return }
        guard let vc = uiViewController as? FSCalendarViewController else { return }
        vc.changeScope(type)
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
        
        // 선택한 날짜 변경
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            calendar.today = date
            vm.action(.selectedDate(date: date))
            animateByDate(date)
        }
        
        // 선택한 날짜와 현재 날짜 비교해서 미래라면 다음 페이지로 과거라면 이전 페이지로
        private func animateByDate(_ selectedDate: Date) {
            guard calendar.scope.rawValue == 0 else { return }
            let selectedMonth = Calendar.current.component(.month, from: selectedDate)
            let thisMonth = Calendar.current.component(.month, from: calendar.currentPage)
            guard selectedMonth != thisMonth else { return }
            calendar.setCurrentPage(selectedDate, animated: true)
        }
        
        // 달력 페이지 바뀔 때마다 currentDate 변경
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            sendCurrentPageDate()
        }
        
        // 주간 모드에서 다음달 또는 이전달 날짜 선택한 상태에서 월간 모드로 돌아갔을 때, currenPage가 바뀌었을 가능성 O
        // => currentDate 변경
        func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
            guard calendar.scope.rawValue == 0 else { return }
            sendCurrentPageDate()
        }
        
        // 뷰모델로 데이터 전송
        private func sendDatas() {
            vm.action(.selectedDate(date: calendar.today))
            sendCurrentPageDate()
        }
        
        // 현재 페이지 날짜 보내기 => currentDate 변경
        private func sendCurrentPageDate() {
            let date = Calendar.current.dateComponents([.month, .year], from: calendar.currentPage)
            let year = date.year
            let month = date.month
            vm.action(.currentDate(year: year, month: month))
        }
        
        // BottomSheet의 상태에 따라 달력 월간 또는 주간으로 변경
        func changeScope(_ data: PresentationDetent) {
            let isMidSheet = data == Detents.mid.detents
            calendar.scope = isMidSheet ? .month : .week
        }
    }
}

//
//  CalendarMonthViewController.swift
//  Calendar
//
//  Created by Lubos Ilcik on 10/11/2018.
//  Copyright © 2018 Guerillacraft All rights reserved.
//

import UIKit
import JTAppleCalendar



class CalendarMonthViewController: UIViewController {
    
    @IBOutlet private weak var calendarCollectionView: JTAppleCalendarView! {
        didSet {
            calendarCollectionView.register(UINib(nibName: CalendarCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCell.identifier)
        }
    }

    @IBOutlet private weak var calendarViewBottomConstraint: NSLayoutConstraint!
    
    private let backItem = UIBarButtonItem()
    private let today = Date()
    private let calendarRows = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hideShadow = true
        setNavbarBackTitle(date: today)
        scrollToDate(today, animate: false)
    }
    
    @IBAction private func onTodayTapped() {
        scrollToDate(today, animate: true)
    }

}

private extension DateSegmentInfo {
    var rows: Int {
        let result = (Float(indates.count + monthDates.count) / 7).rounded(.up)
        return Int(result)
    }
}

extension CalendarMonthViewController {
    private func scrollToDate(_ date: Date, animate: Bool) {
        calendarCollectionView.scrollToDate(date, triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0) { [unowned self] in
            self.calendarCollectionView.deselectAllDates()
            self.calendarCollectionView.selectDates([date])
        }
    }
    
    private func adjustCalendarViewHeight(numberOfRows: Int) {
        let adjust = numberOfRows < calendarRows
        calendarViewBottomConstraint.constant = adjust ? -calendarCollectionView.frame.height / CGFloat(calendarRows) : 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

}

extension CalendarMonthViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        #warning("TODO: set startDate/endDate relative to current year with N years range")
        var calendar = Calendar.current
        calendar.firstWeekday = DaysOfWeek.monday.rawValue // monday!!!
        let formatter = DateFormatter.yyyyMMdd
        formatter.locale = calendar.locale
        formatter.timeZone = calendar.timeZone
        let startDate = formatter.date(from: "1900-01-01")!
        let endDate = formatter.date(from: "2050-12-31")!
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: calendarRows,
                                       calendar: calendar,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: true)
    }
    
}

extension CalendarMonthViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        cell.model = CalendarCellModel(from: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        cell.model = CalendarCellModel(from: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        (cell as! CalendarCell).model = CalendarCellModel(from: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.model = CalendarCellModel(from: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setNavbarBackTitle(date: visibleDates.monthDates.first?.date)
        adjustCalendarViewHeight(numberOfRows: visibleDates.rows)
    }
    
    private func setNavbarBackTitle(date: Date?) {
        guard let date = date else { return }
        backItem.title = DateFormatter.MMMyyyy.string(from: date)
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
}

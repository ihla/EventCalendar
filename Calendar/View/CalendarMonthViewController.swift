//
//  CalendarMonthViewController.swift
//  Calendar
//
//  Created by Lubos Ilcik on 10/11/2018.
//  Copyright © 2018 Guerillacraft All rights reserved.
//

import UIKit
import JTAppleCalendar

#warning("TODO: try to slim down the controller")
class CalendarMonthViewController: UIViewController {
    
    @IBOutlet private weak var calendarCollectionView: JTAppleCalendarView! {
        didSet {
            calendarCollectionView.register(UINib(nibName: CalendarCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCell.identifier)
        }
    }

    @IBOutlet private weak var calendarViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: EventCell.identifier, bundle: nil), forCellReuseIdentifier: EventCell.identifier)
            tableView.rowHeight = 50
            tableView.estimatedRowHeight = 50
        }
    }
    
    private let backItem = UIBarButtonItem()
    private let today = Date()
    private let calendarRows = 6
    
    private var monthEvents: [String: [Event]] = [:] {
        didSet {
            guard let _ = calendarCollectionView.selectedDates.first else { return }
            tableView.reloadData()
            calendarCollectionView.reloadData()
        }
    }
    private let interactor = CalendarEventInteractor()
    
    private lazy var currentCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = DaysOfWeek.monday.rawValue // monday!!!
        return calendar
    }()
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter.yyyyMMdd
        formatter.locale = currentCalendar.locale
        formatter.timeZone = currentCalendar.timeZone
        return formatter
    }()

    #warning("TODO: set startDate/endDate relative to current year with N years range")
    private lazy var calendarStartDate: Date = { formatter.date(from: "1970-01-01")! }()
    private lazy var calendarEndDate: Date = { formatter.date(from: "2038-12-31")! }()
    
    private var lastScrolledToDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hideShadow = true
        setNavbarBackTitle(date: today)
        scrollToDate(today, animate: false)
        getEvents()
    }
    
    private func getEvents() {
        interactor.getEvents(start: calendarStartDate, end: calendarEndDate, formatter: formatter) { [weak self] events in
            self?.monthEvents = events
        }
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
    
    private func selectDate(in visibleDates: DateSegmentInfo) {
        guard let firstVisibleDate = visibleDates.monthDates.first?.date, let lastVisibleDate = visibleDates.monthDates.last?.date else { return }
        
        if today >= firstVisibleDate && today <= lastVisibleDate {
            calendarCollectionView.selectDates([today])
        } else {
            calendarCollectionView.selectDates([firstVisibleDate])
        }
    }


}

extension CalendarMonthViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        #warning("TODO: match calendar local settings")
        return ConfigurationParameters(startDate: calendarStartDate,
                                       endDate: calendarEndDate,
                                       numberOfRows: calendarRows,
                                       calendar: currentCalendar,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: true)
    }
    
}

extension CalendarMonthViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        cell.model = CalendarCellModel(from: cellState, events: monthEvents)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        cell.model = CalendarCellModel(from: cellState, events: monthEvents)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        (cell as! CalendarCell).model = CalendarCellModel(from: cellState, events: monthEvents)
        tableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.model = CalendarCellModel(from: cellState, events: monthEvents)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setNavbarBackTitle(date: visibleDates.monthDates.first?.date)
        adjustCalendarViewHeight(numberOfRows: visibleDates.rows)
        let currentScroledToDate = visibleDates.monthDates.first?.date
        if lastScrolledToDate != currentScroledToDate {
            lastScrolledToDate = currentScroledToDate
            selectDate(in: visibleDates)
        }
    }
    
    private func setNavbarBackTitle(date: Date?) {
        guard let date = date else { return }
        backItem.title = DateFormatter.MMMyyyy.string(from: date)
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
}

// MARK: - UITableViewDataSource

extension CalendarMonthViewController: UITableViewDataSource {
    private var selectedDateEvents: [Event] {
        guard let date = calendarCollectionView.selectedDates.first else {
            return []
        }
        return monthEvents[DateFormatter.yyyyMMdd.string(from: date)] ?? []

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = selectedDateEvents.count
        return c
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as! EventCell
        cell.model = EventCellModel(with: selectedDateEvents[indexPath.row])
        return cell
    }
}

extension CalendarMonthViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #warning("TODO: correct cell constraints to allow automatic cell sizing")
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

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
    
    @IBOutlet private weak var calendarCollectionView: UICollectionView! {
        didSet {
            calendarCollectionView.register(UINib(nibName: CalendarCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCell.identifier)
            // inset top -1 to align top line seprator of cel's row with the bottom line separator of day label's row
            calendarCollectionView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hideShadow = true
    }

}

extension CalendarMonthViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        #warning("TODO: set startDate/endDate relative to current year with N years range")
        let startDate = DateFormatter.yyyyMMdd.date(from: "2018-01-01")!
        let endDate = DateFormatter.yyyyMMdd.date(from: "2018-12-31")!
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: 6,
                                       calendar: Calendar.current,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .off,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: true)
    }
    
}

extension CalendarMonthViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
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
        (cell as! CalendarCell).model = CalendarCellModel(from: cellState)
    }
}

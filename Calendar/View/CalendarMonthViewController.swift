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
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hideShadow = true
    }

}

extension CalendarMonthViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = DateFormatter.yyyyMMdd.date(from: "2018-01-01")!
        let endDate = DateFormatter.yyyyMMdd.date(from: "2018-12-31")!
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: 6,
                                       calendar: Calendar.current,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid,
                                       firstDayOfWeek: .monday,
                                       hasStrictBoundaries: true)
    }
    
}

extension CalendarMonthViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        cell.day = cellState.text
        return cell
    }
    
    
}

//
//  CalendarCell.swift
//  Calendar
//
//  Created by Lubos Ilcik on 11/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    static let identifier = "CalendarCell"
    
    var day: String = "" {
        didSet {
            dayLabel.text = day
        }
    }
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var dotView: UIView!

}

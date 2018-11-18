//
//  CalendarCell.swift
//  Calendar
//
//  Created by Lubos Ilcik on 11/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import UIKit
import JTAppleCalendar

struct CalendarCellModel {
    let day: String
    let isPresented: Bool
    let isSelected: Bool
    let backgroundColor: UIColor
    let textColor: UIColor
    let isEvent: Bool
}

extension CalendarCellModel {
    init() {
        self.init(day: "", isPresented: false, isSelected: false, backgroundColor: UIColor(), textColor: UIColor(), isEvent: false)
    }
}

class CalendarCell: JTAppleCell {
    static let identifier = "CalendarCell"
    
    var model: CalendarCellModel = CalendarCellModel() {
        didSet {
            configure()
        }
    }
    
    override func prepareForReuse() {
        isHidden = false
        dayLabel.text = ""
        dayLabel.textColor = .black
        selectedView.isHidden = true
        dotView.isHidden = true
    }
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var dotView: UIView!

    private func configure() {
        guard model.isPresented else {
            isHidden = true
            return
        }
        dayLabel.text = model.day
        selectedView.isHidden = !model.isSelected
        selectedView.backgroundColor = model.backgroundColor
        dayLabel.textColor = model.textColor
    }
    
}

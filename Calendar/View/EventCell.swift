//
//  EventCell.swift
//  Calendar
//
//  Created by Lubos Ilcik on 24/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import UIKit

struct EventCellModel {
    let title: String
    let note: String
    let startTime: String
    let endTime: String
    let categoryColor: UIColor
}

extension EventCellModel {
    init() {
        self.init(title: "", note: "", startTime: "", endTime: "", categoryColor: .black)
    }
}

class EventCell: UITableViewCell {
    
    static let identifier = "EventCell"

    @IBOutlet private weak var categoryLine: UIView!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    
    var model = EventCellModel() {
        didSet {
            titleLabel.text = model.title
            noteLabel.text = model.note
            startTimeLabel.text = model.startTime
            endTimeLabel.text = model.endTime
            categoryLine.backgroundColor = model.categoryColor
        }
    }
}

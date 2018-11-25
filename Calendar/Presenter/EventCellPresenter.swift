//
//  EventCellPresenter.swift
//  Calendar
//
//  Created by Lubos Ilcik on 24/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import UIKit

extension Event.Category {
    var color: UIColor {
        switch self {
        case .work: return .black
        case .freeTime: return .green
        case .family: return .blue
        }
    }
}

extension EventCellModel {
    init(with model: Event) {
        let formatter = DateFormatter.HHmm
        self.init(title: model.title, note: model.note, startTime: formatter.string(from: model.startTime), endTime: formatter.string(from: model.endTime), categoryColor: model.category.color)
    }
}

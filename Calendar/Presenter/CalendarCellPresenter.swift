//
//  CalendarCellPresenter.swift
//  Calendar
//
//  Created by Lubos Ilcik on 16/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import Foundation
import JTAppleCalendar

extension CalendarCellModel {
    init(from state: CellState) {
        self.init(day: state.text,
                  isPresented: state.dateBelongsTo == .thisMonth,
                  isSelected: state.isSelected,
                  isEvent: false)
    }
}

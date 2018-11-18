//
//  CalendarCellPresenter.swift
//  Calendar
//
//  Created by Lubos Ilcik on 16/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import UIKit
import JTAppleCalendar

extension CalendarCellModel {
    init(from state: CellState) {
        self.init(day: state.text,
                  isPresented: state.dateBelongsTo == .thisMonth,
                  isSelected: state.isSelected,
                  backgroundColor: CalendarCellModel.backgroundColor(state),
                  textColor: CalendarCellModel.textColor(state),
                  isEvent: false)
    }
    
    private static func backgroundColor(_ state: CellState) -> UIColor {
        if Calendar.current.isDateInToday(state.date) {
            return .red
        } else {
            return .black
        }
    }
    
    private static func textColor(_ state: CellState) -> UIColor {
        if state.isSelected {
            return .white
        } else if Calendar.current.isDateInToday(state.date) {
            return .red
        } else if state.day == .sunday || state.day == .saturday {
            return .gray
        } else {
            return .black
        }
    }

}

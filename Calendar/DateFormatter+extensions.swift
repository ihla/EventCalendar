//
//  DateFormatter+extensions.swift
//  Calendar
//
//  Created by Lubos Ilcik on 11/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import Foundation

extension DateFormatter {
    #warning("TODO: remove this formatter when not needed")
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    static let MMMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()
}

//
//  DateFormatter+extensions.swift
//  Calendar
//
//  Created by Lubos Ilcik on 11/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import Foundation

extension DateFormatter {
    #warning("TODO: refactor") // https://williamboles.me/sneaky-date-formatters-exposing-more-than-you-think/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B376
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
    static let HHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

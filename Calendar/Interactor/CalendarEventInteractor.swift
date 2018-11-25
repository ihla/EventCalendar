//
//  CalendarEventInteractor.swift
//  Calendar
//
//  Created by Lubos Ilcik on 24/11/2018.
//  Copyright © 2018 Guerillacraft. All rights reserved.
//

import Foundation

struct Event {
    enum Category { case work, freeTime, family }
    let title: String
    let note: String
    let startTime: Date
    let endTime: Date
    let category: Category
}

final class CalendarEventInteractor {
    
    /// passing formatter to guarantee dates formats used by calendar
    func getEvents(start: Date, end: Date, formatter: DateFormatter, completion: @escaping ([String: [Event]]) -> ()) {
        // test data
        var events = [String: [Event]]()
        DispatchQueue.global().async {
            var eventDateStr = "2018-01-15"
            var eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-02-10"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .family)]

            eventDateStr = "2018-03-22"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime)]

            eventDateStr = "2018-04-12"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-05-01"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-06-17"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-07-23"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .family)]
            
            eventDateStr = "2018-08-12"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-09-22"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-10-12"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-11-12"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2018-11-24"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]

            eventDateStr = "2018-11-30"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .family),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]
            
            eventDateStr = "2019-01-24"
            eventDate = formatter.date(from: eventDateStr)!
            events[eventDateStr] = [Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .family),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .freeTime),
                                    Event(title: "Test event", note: "bla bla bla bla", startTime: eventDate, endTime: eventDate, category: .work)]

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(events)
        }
    }
    
}

//
//  DateExtension.swift
//  WatchTest
//
//  Created by Matias La Delfa on 01/06/2023.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var yesterday2: Date { return Date().customBefore(2) }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    func customBefore(_ value: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -value, to: noon)!
    }
    
    func workoutFormat() -> String {
        return Formatter.workoutFormatter.string(from: self)
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
}

//
//  FormatStyleExtension.swift
//  WatchTest
//
//  Created by Matias La Delfa on 28/03/2023.
//

import Foundation

// MARK: - FormatStyle
struct ElapsedTimeStyle: FormatStyle {
    typealias FormatInput = TimeInterval
    typealias FormatOutput = String
    
    var showSubseconds = true
    
    func format(_ value: TimeInterval) -> String {
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad
        
        guard let formattedString = timeFormatter.string(from: value) else {
            return value.asString
        }

        if showSubseconds {
            let hundredths = Int((value.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }

        return value.asString
    }
}

struct TotalTimeStyle: FormatStyle {
    typealias FormatInput = TimeInterval
    typealias FormatOutput = String
    
    func format(_ value: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: value) ?? ""
    }
}

extension FormatStyle where Self == ElapsedTimeStyle {
    static var elapsedTime: ElapsedTimeStyle { .init() }
    static var totalTime: TotalTimeStyle { .init() }
}

// MARK: - Formatter
class ElapsedTimeFormatter: Formatter {
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        return time.asString
    }
}

extension Formatter {
    static let workoutFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

//
//  HKWorkoutActivityTypeExtension.swift
//  WatchTest
//
//  Created by Matias La Delfa on 31/05/2023.
//

import SwiftUI
import HealthKit

extension HKWorkoutActivityType: Identifiable, Codable {
    public var id: UInt {
        return rawValue
    }
    
    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        case .soccer:
            return "Football"
        default:
            return ""
        }
    }
    
    var icon: Image {
        switch self {
        case .running:
            return Image(systemName: "figure.run")
        case .cycling:
            return Image(systemName: "figure.outdoor.cycle")
        case .walking:
            return Image(systemName: "figure.walk")
        case .soccer:
            return Image(systemName: "figure.soccer")
        default:
            return Image(systemName: "")
        }
    }
}

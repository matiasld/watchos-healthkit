//
//  WorkoutProgressView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 11/10/2023.
//

import SwiftUI
import HealthKit

struct WorkoutProgressView: View {
    let progress: Double
    let goal: Double = 5.0
    let type: HKWorkoutActivityType = .running
    
    var body: some View {
        ZStack {
            CircularProgressView(progress: progress,
                                 primaryColor: .gamma300,
                                 secondaryColor: .gamma50)
            VStack {
                iconImage
                goalText
                Text("Total Distance")
                    .font(.walsheimPro(weight: .medium, size: .largeFont))
            }
            .foregroundColor(.alpha800)
        }
    }
    
    var goalText: some View {
        Text("\(goalValue) km")
            .font(.walsheimPro(weight: .bold, size: .xLargeFont))
    }
    
    var iconImage: some View {
        type.icon
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundColor(.gamma300)
    }
    
    var goalValue: String {
        let calc = goal * progress
        return calc.normalized()
    }
}

struct WorkoutProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WorkoutProgressView(progress: 0.5)
                .frame(width: 300)
                .padding()
            GoalProgressView(progress: 2400, type: .time)
                .frame(width: 70)
                .padding()
        }
    }
}

// MARK: - Goals
enum GoalProgressType {
    case calories, heart, time
    
    var unit: String {
        switch self {
        case .calories:
            return "kcal"
        case .heart:
            return "bpm"
        case .time:
            return "min"
        }
    }
}

struct GoalProgressView: View {
    let progress: Double
    let type: GoalProgressType
    
    var body: some View {
        VStack {
            ZStack {
                CircularProgressView(progress: progress,
                                     strokeWidth: 7,
                                     primaryColor: mainColor,
                                     secondaryColor: backColor)
                iconImage
            }
            HStack {
                Text(progressValue)
            }
            .fixedSize()
        }
    }
    
    var progressValue: String {
        let val: Double = type == .time ? (progress / 60) : progress
        return "\(val.asString) \(type.unit)"
    }
    
    var iconImage: Image {
        switch type {
        case .calories:
            return Image("FireGoal")
        case .heart:
            return Image("Heart")
        case .time:
            return Image("Timewatch")
        }
    }
    
    var mainColor: Color {
        switch type {
        case .calories:
            return .gamma300
        case .heart:
            return .delta400
        case .time:
            return .epsilon500
        }
    }
    
    var backColor: Color {
        switch type {
        case .calories:
            return .gamma50
        case .heart:
            return .delta50
        case .time:
            return .epsilon50
        }
    }
}

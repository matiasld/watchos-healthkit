//
//  WorkoutView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 15/06/2023.
//

import SwiftUI
import HealthKit

struct WorkoutView: View {
    let workout: Workout
        
    var body: some View {
        VStack(spacing: 32) {
            headerView
            
            VStack(spacing: 30) {
                WorkoutProgressView(progress: workout.progress)
                    .padding(.horizontal, 50)
                Text("Summary")
                    .font(.walsheimPro(weight: .bold, size: .large2Font))
                HStack {
                    Spacer()
                    GoalProgressView(progress: workout.energyBurned, type: .calories)
                        .frame(width: 70)
                    Spacer()
                    GoalProgressView(progress: workout.avgHeartRate, type: .heart)
                        .frame(width: 70)
                    Spacer()
                    GoalProgressView(progress: workout.duration, type: .time)
                        .frame(width: 70)
                    Spacer()
                }
                Spacer()                
            }
        }
        .multilineTextAlignment(.center)
        .padding(.all, 15)
    }
    
    var headerView: some View {
        VStack(spacing: .medium2) {
            Text("Daily Workouts")
                .font(.walsheimPro(size: .mediumFont))
                .foregroundColor(.gamma400)
            Text("You have ran\n\(progressString) of your goal ")
        }
        .font(.walsheimPro(weight: .medium, size: .large5Font))
        .foregroundColor(.alpha800)
    }
    
    var progressString: AttributedString {
        let progressPercent = workout.progress * 100
        var attributedText = AttributedString(progressPercent.asString + "%")
        attributedText.foregroundColor = .gamma400
        return attributedText
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout(duration: 2700, distance: 3000, energyBurned: 1200, avgHeartRate: 112, type: .running, date: Date.now))
    }
}

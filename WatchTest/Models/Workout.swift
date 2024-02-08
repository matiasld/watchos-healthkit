//
//  Workout.swift
//  WatchTest
//
//  Created by Matias La Delfa on 05/10/2023.
//

import HealthKit

struct Workout: Identifiable, Hashable, Codable {
    var id = UUID()
    let duration: TimeInterval // Seconds
    let distance: Double // Meters
    let energyBurned: Double // KiloCalories
    let avgHeartRate: Double // bpm
    let type: HKWorkoutActivityType
    let date: Date
    
    init(from workout: HKWorkout, avgHeartRate: Double) {
        duration = workout.duration
        distance = workout.totalDistance?.doubleValue(for: .meter()) ?? 0.0
        energyBurned = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0.0
        type = workout.workoutActivityType
        date = workout.endDate
        self.avgHeartRate = avgHeartRate
    }
    
    init(duration: Double, distance: Double, energyBurned: Double, avgHeartRate: Double, type: HKWorkoutActivityType, date: Date) {
        self.duration = duration
        self.distance = distance
        self.energyBurned = energyBurned
        self.avgHeartRate = avgHeartRate
        self.type = type
        self.date = date
    }
    
    var progress: Double {
        let goal: Double = 5_000
        return distance > 5_000 ? 1 : distance/goal
    }
}

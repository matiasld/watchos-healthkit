//
//  HomeViewModel.swift
//  WatchTest
//
//  Created by Matias La Delfa on 11/10/2023.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private let healthManager = HealthKitManager()
    private var workoutService = WatchService<Workout>()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        workoutService.message
            .sink(receiveValue: { workout in
                WorkoutIntent.shared.workouts.append(workout)
            })
            .store(in: &cancellables)
    }
    
    func requestHealthData() {
        healthManager.startQueryForActivitySummary()
        healthManager.startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
}

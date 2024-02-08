//
//  HomeViewModel.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 29/01/2023.
//

import SwiftUI
import Combine
import HealthKit

class WorkoutIntent: ObservableObject {
    static let shared = WorkoutIntent()
    
    @Published var heartRate: String = "63 BPM"
    @Published var sleepTime: String = "8.3 Hrs"
    @Published var activitySum = ActivitySummary()
    @Published var workouts: [Workout] = [
        Workout(duration: 2400, distance: 2700, energyBurned: 800, avgHeartRate: 102, type: .running, date: Date.yesterday),
        Workout(duration: 3500, distance: 5000, energyBurned: 1200, avgHeartRate: 112, type: .running, date: Date().customBefore(3))
    ]
    
    var hkactivitySum: HKActivitySummary?
    
    private let healthManager = HealthKitManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        healthManager.summaryPublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                print("Activity summary pulished")
            }, receiveValue: { summary in
                self.activitySum = summary
            })
            .store(in: &cancellables)
        
        healthManager.hksummaryPublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                print("hkActivity summary published")
            }, receiveValue: { summary in
                self.hkactivitySum = summary
            })
            .store(in: &cancellables)
        
        healthManager.heartRateValues
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                print("heartRate pulished")
            }, receiveValue: { rate in
                guard let rate = rate else { return }
                self.heartRate = "\(rate) BPM"
            })
            .store(in: &cancellables)
    }
}

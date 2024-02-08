//
//  SummaryView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 14/02/2023.
//

import Foundation
import SwiftUI
import WatchKit

struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    private let saveService = WatchService<Workout>()
    
    private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.results == nil {
            ProgressView("Saving Workout")
                .navigationBarHidden(true)
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    SummaryMetricView(title: "Total Time",
                                      value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                        .foregroundStyle(Color.gamma300)
                    SummaryMetricView(title: "Total Distance",
                                      value: Measurement(value: workoutManager.workout?.totalDistance?.doubleValue(for: .meter()) ?? 0,
                                                         unit: UnitLength.meters)
                                        .formatted(.measurement(width: .abbreviated,
                                                                usage: .asProvided,
                                                                numberFormatStyle: .number.precision(.fractionLength(2)))))
                        .foregroundStyle(.green)
                    SummaryMetricView(title: "Total Energy",
                                      value: Measurement(value: workoutManager.workout?.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0,
                                                         unit: UnitEnergy.kilocalories)
                                        .formatted(.measurement(width: .abbreviated,
                                                                usage: .workout,
                                                                numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .foregroundStyle(.pink)
                    SummaryMetricView(title: "Avg. Heart Rate",
                                      value: workoutManager.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                        .foregroundStyle(.red)
                    activityRing
                    
                    Button("Send") {
                        didTapSend()
//                        dismiss()
                    }
                }
                .scenePadding()
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.dark100)
        }
    }
    
    var activityRing: some View {
        VStack(alignment: .leading) {
            Text("Activity Rings")
                .font(.walsheimPro(weight: .medium, size: 16))
            ActivityRingsView(healthStore: workoutManager.healthStore)
                .frame(width: 50, height: 50)
        }
        .padding(10)
    }
    
    func didTapSend() {
        guard let workout = workoutManager.results else { return }
        saveService.send(workout)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var manager: WorkoutManager = {
        let manager = WorkoutManager()
        manager.selectedWorkout = .running
        manager.results = Workout(duration: 120, distance: 100, energyBurned: 3000, avgHeartRate: 122, type: .running, date: Date.now)
        return manager
    }()
    
    static var previews: some View {
        NavigationStack {
            SummaryView()
                .environmentObject(manager)
        }
    }
}

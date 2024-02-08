//
//  HealthKitManager.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 24/01/2023.
//

import Foundation
import HealthKit
import Combine

struct HeartRateModel {
    var heartRate: Double
    var heartRateVariability: Double
}

enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
    case authorizationFailed
}

final class HealthKitManager {
    
    private let healthStore: HKHealthStore = HKHealthStore()
    
    // TODO: Replace 'Error' with 'Never', avoid having publisher ended.
    let summaryPublisher = PassthroughSubject<ActivitySummary, Error>()
    let hksummaryPublisher = PassthroughSubject<HKActivitySummary, Error>()
    let heartRateValues = CurrentValueSubject<Int?, Error>(nil)
    
    private let heartRateQuantity = HKUnit(from: "count/min")
    private var activeQueries: [HKQuery] = []
    
    var isAuthorized: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        // Defines types of health data to request
        var readTypes = Set<HKObjectType>()
        
        guard let distanceWalkingRunningType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
              let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
              let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        readTypes.insert(distanceWalkingRunningType)
        readTypes.insert(stepsType)
        readTypes.insert(heartRate)
        readTypes.insert(sleepAnalysis)
        readTypes.insert(HKObjectType.activitySummaryType()) // Activity Ring data (Move, Exercise, Stand)
        
        // Request auth for selected types
        healthStore.requestAuthorization(toShare: nil, read: readTypes, completion: completion)
    }
    
    func startSleepQuery(from startDate: Date?, to endDate: Date?) {
        
        // First we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        // We create a predicate to filter our data
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // A sortDescriptor to get the recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // We create our query with a block completion to execute
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            guard error == nil else {
                print("HealthKit error: \(error)")
                return
            }
            
            if let result = result {
                result
                    .compactMap({ $0 as? HKCategorySample })
                    .forEach({ sample in
                        guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                            return
                        }
                        
                        let isAsleep = sleepValue == .asleepUnspecified
                        
                        print("HealthKit sleep \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                    })
            }
        }
        
        healthStore.execute(query)
    }
    
    func writeSleep(_ sleepAnalysis: HKCategoryValueSleepAnalysis, startDate: Date, endDate: Date) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        // We create our new object we want to push in Health app
        let sample = HKCategorySample(type: sleepType, value: sleepAnalysis.rawValue, start: startDate, end: endDate)
        
        healthStore.save(sample) { (success, error) in
            guard success && error == nil else {
                // handle error
                return
            }
        }
    }
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            
        // We want data points from our current device
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // A sample that represents a quantity, including the value and the units.
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            // process-------------
            // variable initialization
            var lastHeartRate = 0.0
            
            // cycle and value assignment
            for sample in samples {
                if quantityTypeIdentifier == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: self.heartRateQuantity)
                }
                
                self.heartRateValues.value = Int(lastHeartRate)
            }
            //--------------------
        }
        
        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        healthStore.execute(query)
    }
    
//    func fetchHeartRateData(quantityTypeIdentifier: HKQuantityTypeIdentifier ) {
//        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
//        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
//        query, samples, deletedObjects, queryAnchor, error in
//            guard let samples = samples as? [HKQuantitySample] else {
//                return
//            }
//            for sample in samples {
//                if quantityTypeIdentifier == .heartRate {
////                        self.heartRateValues.heartRate = sample.quantity.doubleValue(for: self.heartRateQuantity)
//                    self.heartRateValues.value = sample.quantity.doubleValue(for: self.heartRateQuantity)
//
//                } else if quantityTypeIdentifier == .heartRateVariabilitySDNN {
////                        self.heartRateValues.heartRateVariability = sample.quantity.doubleValue(for: self.heartRateVariabilityQuantity)
//                        // TODO: Send heart rate data
//                    print("Heart rate VAR.: \(sample.quantity.doubleValue(for: self.heartRateQuantity))")
//                }
//            }
//        }
//        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
//        query.updateHandler = updateHandler
//        healthStore.execute(query)
//        activeQueries.append(query) // TODO: Check if needed
//    }
    
    func startQueryForActivitySummary() {
        let calendar = Calendar.autoupdatingCurrent
        
        // This sets date for current day activity
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        dateComponents.calendar = calendar
        
        let queryPredicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        // Setup Query
        let query = HKActivitySummaryQuery(predicate: queryPredicate) { (query, summaries, error) -> Void in
            
            guard let summaries = summaries else {
                // No data returned. Perhaps check for error
                return
            }
            
            // Handle the activity rings data here
            for summary in summaries {
                let activeEnergyBurned = summary.activeEnergyBurned.doubleValue(for: .kilocalorie())
                let activeEnergyBurnedGoal = summary.activeEnergyBurnedGoal.doubleValue(for: .kilocalorie())
                let appleExerciseTime = summary.appleExerciseTime.doubleValue(for: .minute())
                let appleStandHours = summary.appleStandHours.doubleValue(for: .count())
                let activitySummary = ActivitySummary(move: activeEnergyBurned, excercise: appleExerciseTime, stand: appleStandHours)
                
                self.summaryPublisher.send(activitySummary)
                self.hksummaryPublisher.send(summary)
            }
        }
        healthStore.execute(query)
    }
    
    func startQueryForWorkouts() {
        // TODO: Refactor "readWorkouts" with Combine
    }
    
    func readWorkouts() async -> [HKWorkout]? {
        let cycling = HKQuery.predicateForWorkouts(with: .cycling)

        let samples = try? await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
            let query = HKSampleQuery(sampleType: .workoutType(),
                                      predicate: cycling,
                                      limit: HKObjectQueryNoLimit,
                                      sortDescriptors: [.init(keyPath: \HKSample.startDate, ascending: false)],
                                      resultsHandler: { query, samples, error in
                
                if let hasError = error {
                    continuation.resume(throwing: hasError)
                    return
                }
                
                guard let samples = samples else {
                    fatalError("*** Invalid State: This can only fail if there was an error. ***")
                }
                
                continuation.resume(returning: samples)
            })
            healthStore.execute(query)
        }

        guard let workouts = samples as? [HKWorkout] else { return nil }
        return workouts
    }
}

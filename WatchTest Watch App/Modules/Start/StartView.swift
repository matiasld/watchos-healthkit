//
//  ContentView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 09/02/2023.
//

import SwiftUI
import HealthKit

struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    let workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking, .soccer]
        
    var body: some View {
        VStack {
            List(workoutTypes) { type in
                // TODO: Refactor into NavigationStack.
                // Using NavigationLink with NavigationStack will ignore changes on passed 'selection' parameter.
                NavigationLink(destination: SessionPagingView(), tag: type,
                               selection: $workoutManager.selectedWorkout, label: {
                    WorkoutCell(title: type.name, iconImage: type.icon)
                })
            }
        }
        .listStyle(.carousel)
        .navigationBarTitle("Workouts")
        .onAppear {
            workoutManager.requestAuthorization()
        }
        
        // TEST: Watch communication
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.mint)
//            Text("HealthWatch")
//            Button("Send", action: {
//                WatchConnectivityManager.shared.send("Hello World!\n\(Date().ISO8601Format())")
//            })
//        }
//        .padding()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartView()
                .environmentObject(WorkoutManager())
        }
    }
}

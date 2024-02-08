//
//  ControlView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 13/02/2023.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                    workoutManager.togglePause()
                } label: {
                    Image(systemName: workoutManager.running ? "pause" : "play")
                }
                .tint(.delta400)
                .font(.title2)
                Text(workoutManager.running ? "Pause" : "Resume")
            }
        }
    }
}

// MARK: - Preview
struct ControlsView_Previews: PreviewProvider {
    static var manager: WorkoutManager = {
        let man = WorkoutManager()
        return man
    }()
    
    static var previews: some View {
        NavigationStack {
            ControlsView()
                .environmentObject(manager)
                .onAppear {
                    manager.startWorkout(workoutType: .running)
                }
        }
    }
}

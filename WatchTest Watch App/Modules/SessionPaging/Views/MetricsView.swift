//
//  MetricsView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 10/02/2023.
//

import Foundation
import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: refreshRate)) { context in
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text(workoutManager.elapsedTime.formatted(.elapsedTime))
                        .bold()
                        .foregroundColor(.gamma300)
                    
                    Text("\(workoutManager.activeEnergy.normalized()) kCAL")
                    
                    Text("\(workoutManager.distance.normalized()) M")
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(workoutManager.heartRate.asString + " bpm")
                    Spacer()
                }
                    .font(.headline)
                    .padding(.bottom)
            }
            .fixedSize()
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
    }
    
    /// Sets screen refresh rate in case the screen went low power mode.
    var refreshRate: TimeInterval {
        return isLuminanceReduced ? 1 : 1/30
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
            .environmentObject(WorkoutManager())
    }
}

//
//  WatchTestApp.swift
//  WatchTest
//
//  Created by Matias La Delfa on 09/02/2023.
//

import SwiftUI

@main
struct WatchTestApp: App {
    @StateObject var router = Router()
    @StateObject var workoutState = WorkoutIntent.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                GetStartedView()
                    .preferredColorScheme(.light)
                    .navigationDestination(for: Route.self) { destination in
                        destination.build()
                    }
            }
            .environmentObject(router)
            .environmentObject(workoutState)
        }
    }
}

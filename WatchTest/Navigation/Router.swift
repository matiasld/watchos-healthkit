//
//  Router.swift
//  WatchTest
//
//  Created by Matias La Delfa on 27/09/2023.
//

import SwiftUI

enum Route: Hashable {
    case getStarted
    case home
    case activity(ActivitySectionType)
    case workout(Workout)
    
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .getStarted:
            GetStartedView()
        case .home:
            HomeView()
        case .activity(let type):
            buildActivity(type: type)
        case .workout(let work):
            WorkoutView(workout: work)
        }
    }
    
    @ViewBuilder
    func buildActivity(type: ActivitySectionType) -> some View {
        switch type {
        case .steps:
            StepsView()
        case .sleep:
            SleepView()
        case .pulse:
            Color.red
        case .oxygen:
            Color.green
        }
    }
}

final class Router: ObservableObject {
    
    // NavigationPath lets me work as a collection of erased-type Hashable elements for the navigation stack.
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Route) {
        DispatchQueue.main.async {
            self.navPath.append(destination)
        }
    }
    
    func navigateBack() {
        DispatchQueue.main.async {
            self.navPath.removeLast()
        }
    }
    
    func navigateRoot() {
        DispatchQueue.main.async {
            self.navPath.removeLast(self.navPath.count)
        }
    }
}

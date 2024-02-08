//
//  SessionPagingView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 10/02/2023.
//

import SwiftUI
import WatchKit

struct SessionPagingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onChange(of: workoutManager.running) { _ in
            withAnimation {
                selection = .metrics
            }
        }
    }
}

struct SessionPagingView_Previews: PreviewProvider {
    static var manager: WorkoutManager = {
        let man = WorkoutManager()
        man.selectedWorkout = .running
        return man
    }()
    
    static var previews: some View {
        NavigationView {
            SessionPagingView()
                .environmentObject(manager)
        }
    }
}

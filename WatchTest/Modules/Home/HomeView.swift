//
//  HomeView.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 20/01/2023.
//

import SwiftUI
import Combine

struct HomeSectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.walsheimPro(weight: .bold, size: .large2Font))
            Spacer()
            Text("Show More")
                .font(.walsheimPro(weight: .medium, size: .small2Font))
                .foregroundColor(.gamma400)
        }
        .padding([.leading, .trailing], 8)
    }
}

struct HomeView: View {
    @EnvironmentObject var workoutState: WorkoutIntent
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                header
                
                ActivitySectionView()
                
                WorkoutSectionView(workouts: workoutState.workouts)
            }
            .padding([.leading, .trailing], 40)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.requestHealthData()
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(Date.now, format: .dateTime.day().month().year())
                .foregroundColor(.gamma400)
                .font(.walsheimPro(weight: .bold, size: .smallFont))
            Text("Hi, Jeas")
                .foregroundColor(.alpha800)
                .font(.walsheimPro(weight: .bold, size: 28))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(WorkoutIntent())
    }
}

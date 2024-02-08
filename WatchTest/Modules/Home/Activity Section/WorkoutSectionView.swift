//
//  WorkoutView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 01/06/2023.
//

import SwiftUI

struct WorkoutSectionView: View {
    @EnvironmentObject var router: Router
    
    let workouts: [Workout]
    
    var body: some View {
        VStack {
            HomeSectionHeader(title: "Workouts")
            ForEach(workouts) { workout in
                WorkoutListItem(data: workout)
                    .onTapGesture {
                        router.navigate(to: .workout(workout))
                    }
            }
        }
    }
}

struct WorkoutListItem: View {
    let data: Workout
    
    var body: some View {
        HStack(spacing: .smallPlus) {
            Image("Steps")
                .resizable()
                .frame(width: 35, height: 35)
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text("\(data.type.name)")
                    .font(.walsheimPro(weight: .regular, size: .small2Font))
                
                Text("\(data.duration.formatted(.totalTime))")
                    .font(.walsheimPro(weight: .bold, size: .largeFont))
                    .foregroundColor(.gamma400)
            }
            
            Spacer()
            
            VStack {
                Spacer()
                Text(getDate())
                    .font(.walsheimPro(weight: .regular, size: .smallFont))
            }
        }
        .padding([.top, .bottom], .middle)
        .padding([.leading, .trailing], .large)
        .background(Color.alpha50)
        .cornerRadius(.large)
    }
    
    func getDate() -> String {
        return data.date.isToday() ? "Today".localizedCapitalized : data.date.workoutFormat()
    }
}

struct WorkoutSectionView_Previews: PreviewProvider {
    static let workouts: [Workout] = [
        Workout(duration: 2400, distance: 3000, energyBurned: 1000, avgHeartRate: 115, type: .running, date: Date()),
        Workout(duration: 1000, distance: 1000, energyBurned: 800, avgHeartRate: 102, type: .running, date: Date()),
        Workout(duration: 3005, distance: 5000, energyBurned: 1200, avgHeartRate: 112, type: .running, date: Date())
    ]
    static var previews: some View {
        ScrollView {
            WorkoutSectionView(workouts: workouts)
                .padding([.leading, .trailing], 40)
                .environmentObject(Router())
        }
    }
}

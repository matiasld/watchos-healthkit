//
//  StepsView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 01/06/2023.
//

import SwiftUI

// TODO: Make text use all available horizontal space

struct StepsView: View {
    @EnvironmentObject var workoutState: WorkoutIntent
    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone
    @State var dates: Set<DateComponents> = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Step count is a useful metric that allows us to track your daily activity and aid in its improvement.")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(.alpha800)
                .font(.walsheimPro(weight: .regular, size: .mediumFont))
            
            MultiDatePicker("Dates Available", selection: $dates)
                .allowsHitTesting(false)
                .fixedSize()
            
            bottomMessage
            
            Spacer()
        }
        .padding([.leading, .trailing], 24)
        .onAppear(perform: {
            updateDates()
        })
    }
    
    var bounds: Range<Date> {
        let start = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 6))!
        let end = calendar.date(from: DateComponents(
            timeZone: timeZone, year: 2022, month: 6, day: 16))!
        return start ..< end
    }
    
    var bottomMessage: some View {
        HStack {
            Text("You have a high average activity, keep up the good work.")
                .foregroundColor(.gamma400)
                .font(.walsheimPro(weight: .bold, size: .mediumFont))
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.gamma50)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gamma400, lineWidth: 1)
        }
    }
    
    func updateDates() {
        let allDates = workoutState.workouts.map { $0.date }
        let dateComponents = allDates.compactMap { date in
            return Calendar.current.dateComponents([.day, .month, .year], from: date)
        }
        dates = Set(dateComponents)
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
            .environmentObject(WorkoutIntent())
    }
}

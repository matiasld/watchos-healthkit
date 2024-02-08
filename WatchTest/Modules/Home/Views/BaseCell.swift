//
//  BaseCell.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 20/01/2023.
//

import SwiftUI

enum BaseCellType: String, CaseIterable, Identifiable {
    case activity = "🔥 Activity"
    case heartRate = "💗 Heart Rate"
    case sleep = "🛌 Sleep"
    
    var color: Color {
        switch self {
        case .activity:
            return .red
        case .heartRate:
            return .pink
        case .sleep:
            return .mint
        }
    }
    
    var id: Self {
        return self
    }
}

struct BaseCell: View {
    @EnvironmentObject var viewModel: WorkoutIntent
    let type: BaseCellType
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(type.rawValue)
                    .foregroundColor(type.color)
                    .bold()
                Spacer()
                Button(action: {
                    print("see more tapped")
                    if type == .heartRate {
//                        viewModel.requestHealthData()
                    }
                }, label: {
                    Text("See more")
                })
                .buttonStyle(.bordered)
            }
            Spacer()
                .frame(height: 20)
            // Dynamic content
            switch type {
            case .activity:
                BaseActivityCell()
            case .heartRate:
                BaseHeartCell(heartRate: "122bpm")
            case .sleep:
                BaseSleepCell(sleepTime: "8hrs")
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .frame(minHeight: 100, maxHeight: 200)
    }
}

// MARK: - Specific Cell Views
struct BaseActivityCell: View {
    @EnvironmentObject var viewModel: WorkoutIntent
    
    var body: some View {
        HStack{
            VStack {
                Text("Move")
                    .bold()
                    .foregroundColor(.red)
                Spacer()
                Text(viewModel.activitySum.move.asString + " cal")
                    .bold()
            }
            Divider()
            VStack {
                Text("Exercise")
                    .bold()
                    .foregroundColor(.green)
                Spacer()
                Text(viewModel.activitySum.excercise.asString + " min")
                    .bold()
            }
            Divider()
            VStack {
                Text("Stand")
                    .bold()
                    .foregroundColor(.mint)
                Spacer()
                Text(viewModel.activitySum.stand.asString + " hr")
                    .bold()
            }
            
            Spacer()
            ActivityRingView(summary: viewModel.hkactivitySum)
                .frame(width: 60, height: 60)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}

struct BaseHeartCell: View {
    let heartRate: String
    
    var body: some View {
        Text(heartRate)
            .font(.title)
            .bold()
    }
}

struct BaseSleepCell: View {
    let sleepTime: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sleepTime)
                .font(.title)
                .bold()
            Text("Time Asleep")
                .font(.subheadline)
                .foregroundColor(.gray)
                .bold()
        }
    }
}

// MARK: - Previews
struct BaseCell_Previews: PreviewProvider {
    static let viewModel = WorkoutIntent()
    
    static var previews: some View {
        Group {
            VStack {
                ForEach(BaseCellType.allCases) { type in
                    BaseCell(type: type)
                        .previewDisplayName("\(type.rawValue) preview")
                        .previewLayout(PreviewLayout.sizeThatFits)
                        .padding()
                        .background(Color.green)
                    Spacer()
                }
            }
            .previewDisplayName("Default preview")

            ForEach(BaseCellType.allCases) { type in
                BaseCell(type: type)
                    .previewDisplayName("\(type.rawValue) preview")
                    .previewLayout(PreviewLayout.sizeThatFits)
                    .padding()
                    .background(Color.green)
            }
        }
        .environmentObject(viewModel)
    }
}

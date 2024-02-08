//
//  ActivityView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 23/05/2023.
//

import SwiftUI

enum ActivitySectionType: CaseIterable, Identifiable {
    case steps, sleep, pulse, oxygen
    
    var id: Self {
        return self
    }
}

struct ActivitySectionView: View {
    
    @EnvironmentObject var router: Router
    
    let activities: [ActivitySectionType] = [.steps, .sleep, .pulse, .oxygen]
    let columns = [
        GridItem(.flexible(), spacing: .middle),
        GridItem(.flexible(), spacing: .middle)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: .middle) {
            HomeSectionHeader(title: "Activity")
            
            LazyVGrid(columns: columns, spacing: .middle) {
                ForEach(activities, id: \.self) { type in
                    ActivityCardView(type: type)
                        .onTapGesture {
                            router.navigate(to: .activity(type))
                        }
                }
            }
        }
    }
}

struct ActivityCardView: View {
    let type: ActivitySectionType
    
    var body: some View {
        ZStack {
            backgroundColor
            VStack(spacing: .medium3) {
                HStack() {
                    Text(title)
                    Spacer()
                    Image("right_arrow")
                }
                Image(iconName)
                    .frame(height: 82)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("8,740")
                            .font(.walsheimPro(weight: .bold, size: 20))
                        Text("Last update 3min")
                            .font(.walsheimPro(weight: .regular, size: 10))
                    }
                    Spacer()
                }
            }
            .font(.walsheimPro(weight: .bold, size: .mediumFont))
            .foregroundColor(.alpha50)
            .padding(.middle)
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
    }
    
    // MARK: - View Configuration
    var backgroundColor: Color {
        switch type {
        case .steps:
            return .gamma400
        case .sleep:
            return .epsilon500
        case .pulse:
            return .beta500
        case .oxygen:
            return .delta400
        }
    }
    
    var title: String {
        switch type {
        case .steps:
            return "Steps"
        case .sleep:
            return "Sleep"
        case .pulse:
            return "Pulse"
        case .oxygen:
            return "Oxygen blood"
        }
    }
    
    var iconName: String {
        switch type {
        case .steps:
            return "Steps"
        case .sleep:
            return "Sleep"
        case .pulse:
            return "Pulse"
        case .oxygen:
            return "Blood"
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySectionView()
            .padding([.leading, .trailing], 40)
    }
}

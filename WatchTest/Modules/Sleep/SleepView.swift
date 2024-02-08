//
//  SleepView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 01/06/2023.
//

import SwiftUI
import Charts

struct SleepView: View {
    
    let items: [Sleep] = [
        .init(name: "Sleep1", value: 0.9, date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!),
        .init(name: "Sleep2", value: 1.0, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        .init(name: "Sleep3", value: 0.75, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!),
        .init(name: "Sleep3", value: 0.5, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Spacer(minLength: 10)
                
                Text("Sleep duration is a crucial metric that allows us to track your nightly rest and aid in its improvement.")
                    .font(.walsheimPro(weight: .regular, size: .mediumFont))
                
                Chart(items) { item in
                    AreaMark(
                        x: .value("Time", item.date),
                        y: .value("Value", item.value)
                    )
                    
                }
                .frame(height: 215)
                .foregroundStyle(.purple)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 10, y: 10)
                SleepCarrouselView(title: "Today", items: items)
                Divider()
                SleepCarrouselView(title: "Yesterday", items: items)
                Spacer()
            }
        }
        .font(.walsheimPro(weight: .bold, size: .large2Font))
        .padding([.leading, .trailing], 24)
    }
}

struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}

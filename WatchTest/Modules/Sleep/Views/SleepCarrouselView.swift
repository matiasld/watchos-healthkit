//
//  SleepCarrouselView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 11/10/2023.
//

import SwiftUI

enum SleepParam: Identifiable {
    case heartbeat, breathRate, movements
    
    var id: Self {
        return self
    }
}

struct Sleep: Identifiable {
    let id = UUID()
    let name: String
    let type: SleepParam
    let value: Double
    let date: Date
    
    internal init(name: String, value: Double, date: Date, type: SleepParam = .heartbeat) {
        self.name = name
        self.type = type
        self.value = value
        self.date = date
    }
    
    // TODO: Create 'PlottableValue' methods for 'x' and 'y'
}

struct SleepCarrouselView: View {
    let title: String
    let items: [Sleep]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            Text(title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 16) {
                    ForEach(items) { item in
                        // TODO: Separate Sleep model from carrousel content
                        SleepCarrouselItemView(content: item)
                    }
                }
            }
        }
    }
}

struct SleepCarrouselItemView: View {
    let content: Sleep
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(content.name)
                    .font(.walsheimPro(weight: .regular, size: 10))
                Text("54 bpm")
                    .font(.walsheimPro(weight: .medium, size: 14))
                Text("norm")
                    .font(.walsheimPro(weight: .medium, size: 10))
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                    .background(Color.epsilon500)
                    .cornerRadius(5)
            }
            Spacer()
        }
        .frame(width: 95)
        .padding(12)
        .background(Color.epsilon50)
        .cornerRadius(20)
        .multilineTextAlignment(.leading)
    }
}

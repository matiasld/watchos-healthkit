//
//  SummaryMetricView.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 11/10/2023.
//

import SwiftUI

struct SummaryMetricView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.walsheimPro(weight: .bold, size: 14))
                    .foregroundStyle(.foreground)
                Text(value)
                    .font(.system(.title2, design: .rounded).lowercaseSmallCaps())
            }
            Spacer()
        }
        .padding(15)
        .background(Color.dark300)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct SummaryMetricView_Previews: PreviewProvider {
    static let value: TimeInterval = 100
    
    static var previews: some View {
        SummaryMetricView(title: "Total Time",
                          value: value.formatted(.totalTime))
            .foregroundStyle(.red)
    }
}

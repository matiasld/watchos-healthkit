//
//  CircularProgressView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 23/06/2023.
//

import SwiftUI

struct CircularProgressView: View {
    @State private var progressValue: Double = 0
    let progress: Double
    var strokeWidth: CGFloat = 25
    var primaryColor: Color = .gamma300
    var secondaryColor: Color = .gamma50
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    secondaryColor,
                    lineWidth: strokeWidth
                )
            Circle()
                .trim(from: 0, to: progressValue)
                .stroke(
                    primaryColor,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1)
                .onAppear {
                    withAnimation(.easeOut(duration: 1)) {
                        progressValue = progress
                    }
                }
        }
        .padding(strokeWidth/2)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.75)
            .padding()
    }
}

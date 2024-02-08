//
//  ActivityRingView.swift
//  HealthWatch
//
//  Created by Matias La Delfa on 31/01/2023.
//

import SwiftUI
import HealthKitUI

/**
 iOS version of 'ActivityRingView'. Embeds HealthKit's activity ring component in SwiftUI.
 */
struct ActivityRingView: UIViewRepresentable {
//    typealias UIViewType = HKActivityRingView
    let summary: HKActivitySummary?
    
    func makeUIView(context: Context) -> HKActivityRingView {
        let v = HKActivityRingView()
        return v
    }
    
    func updateUIView(_ uiView: HKActivityRingView, context: Context) {
        print("activity ring view updated..")
        guard let summary = summary else { return }
        uiView.setActivitySummary(summary, animated: true)
    }
}

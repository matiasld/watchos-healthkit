//
//  WorkoutCell.swift
//  WatchTest Watch App
//
//  Created by Matias La Delfa on 03/10/2023.
//

import SwiftUI

struct WorkoutCell: View {
    var title: String
    var iconImage: Image
    
    var body: some View {
        HStack {
            iconImage
                .frame(width: 30)
                .foregroundColor(.alpha50)
            Text(title)
        }
        .padding()
    }
}

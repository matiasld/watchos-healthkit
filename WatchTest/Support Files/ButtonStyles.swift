//
//  ButtonStyles.swift
//  WatchTest
//
//  Created by Matias La Delfa on 18/05/2023.
//

import SwiftUI

struct StandardButtonStyle: ButtonStyle {
    var fontSize: CGFloat = .middle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.gamma400)
            .foregroundColor(.white)
            .cornerRadius(.largeRadius)
            .font(.walsheimPro(weight: .medium, size: fontSize))
    }
}

extension ButtonStyle where Self == StandardButtonStyle {
    static var standard: StandardButtonStyle { return StandardButtonStyle() }
}

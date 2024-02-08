//
//  LoginStyle.swift
//  WatchTest
//
//  Created by Matias La Delfa on 03/10/2023.
//

import Foundation
import SwiftUI

struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.walsheimPro(size: .largeFont))
            .padding(10)
            .background(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray300, lineWidth: 3)
            }
            .cornerRadius(10)
    }
}

//
//  FontExtension.swift
//  WatchTest
//
//  Created by Matias La Delfa on 09/05/2023.
//

import SwiftUI

extension Font {
    static func walsheimPro(weight: WalsheimProFonts = .regular, size: CGFloat) -> Font? {
        return Font.custom(weight.rawValue, size: size)
    }
}

enum WalsheimProFonts: String {
    case bold = "GTWalsheimPro-Bold"
    case medium = "GTWalsheimPro-Medium"
    case regular = "GTWalsheimPro-Regular"
    case light = "GTWalsheimPro-Light"
}

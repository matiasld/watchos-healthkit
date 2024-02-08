//
//  ActivityIndicator.swift
//  WatchTest
//
//  Created by Matias La Delfa on 13/02/2023.
//

import SwiftUI

/// Loading spinner, embeds UIActivityIndicatorView for SwiftUI.
struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
}

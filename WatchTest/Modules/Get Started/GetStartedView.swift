//
//  GetStartedView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 05/05/2023.
//

import SwiftUI

struct GetStartedView: View {
    
    var body: some View {
        ZStack {
            Image("getStarted_background")
                .resizable(resizingMode: .stretch)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("MooveWell_logo")
                    .padding()
                titleText
                GetStartedContentView()
            }
        }
        .onAppear(perform: {
            WatchConnectivityManager.shared.connect()
        })
    }
    
    var titleText: some View {
        VStack {
            Text("Welcome to")
                .foregroundColor(.alpha900)
            Text("MooveWell")
                .foregroundColor(.gamma400)
        }
        .font(.walsheimPro(weight: .bold, size: .xLargeFont))
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}

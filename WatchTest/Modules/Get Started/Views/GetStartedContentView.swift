//
//  GetStartedContentView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 03/10/2023.
//

import SwiftUI

struct GetStartedContentView: View {
    @EnvironmentObject var router: Router
    let healthManager = HealthKitManager()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("The easiest way to take care\nof your health!")
                .padding(.all, .medium3)
            
            Spacer()
            
            Button(action: {
                getStartedTapped()
            }, label: {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.standard)
            
            loginText
                .padding(.all, .medium3)
        }
        .padding([.leading, .trailing], 34)
        .multilineTextAlignment(.center)
    }
    
    var loginText: some View {
        VStack {
            Text("Already have an account? ")
                .foregroundColor(.alpha500)
                .font(.walsheimPro(weight: .regular, size: .mediumFont)) +
            Text("Sign In")
                .foregroundColor(.gamma400)
                .font(.walsheimPro(weight: .bold, size: .mediumFont))
        }
        
    }
    
    func getStartedTapped() {
        healthManager.requestAuthorization { isAuthorized, error in
            if error != nil {
                // TODO: Add alert indicating auth failed
                print(error?.localizedDescription ?? "N/A")
                
            } else if isAuthorized {
                router.navigate(to: .home)
            }
        }
    }
}

struct GetStartedContentView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedContentView()
    }
}

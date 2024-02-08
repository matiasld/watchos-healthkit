//
//  LoginView.swift
//  HealthWatch
//
//  Created by Mati on 19/01/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    let healthManager = HealthKitManager()
        
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundColor(.mint)
                Button("Login") {
                    healthManager.requestAuthorization { isAuthorized, error in
                        if error != nil {
                            // TODO: Add alert indicating auth failed
                            print(error?.localizedDescription ?? "N/A")
                            
                        } else if isAuthorized {
                            router.navigate(to: .home)
                        }
                    }
                }
                .buttonStyle(.bordered)
                .tint(.mint)
            }
            .padding()

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.light)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

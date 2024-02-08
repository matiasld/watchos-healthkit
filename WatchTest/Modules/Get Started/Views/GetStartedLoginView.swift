//
//  GetStartedLoginView.swift
//  WatchTest
//
//  Created by Matias La Delfa on 03/10/2023.
//

import SwiftUI

struct GetStartedLoginView: View {
    @State var email: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email")
            TextField(text: $email) {
                Text("Enter your mail")
                    .foregroundColor(.gray500)
            }
            .textFieldStyle(LoginTextFieldStyle())
            Spacer()
                .frame(height: .large2)
            Text("Password")
            
            TextField(text: $email) {
                Text("xxxx")
                    .foregroundColor(.gray500)
            }
            .textFieldStyle(LoginTextFieldStyle())
            
            Spacer()
        }
        .font(.walsheimPro(weight: .medium, size: .mediumFont))
        .padding()
    }
}

struct GetStartedLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedLoginView()
    }
}

//
//  LoginView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authModel: AuthViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Signin to Football Coach")
                .fontWeight(.bold)
                .font(.system(size: 25))
                .padding(.top , 30)
            
            
            Image("soccerball.inverse")
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: {
                Task {
                    do {
                        try await authModel.signIn(email: username, password: password)
                    } catch {
                        print("Login failed:", error.localizedDescription)
                        
                    }
                }
            }) {
                Text("Sign in")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Button(action: {}) {
                Text("Don't have an account? Sign Up")
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    LoginView()
}

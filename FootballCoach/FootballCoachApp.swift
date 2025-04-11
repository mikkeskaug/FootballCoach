//
//  FootballCoachApp.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import SwiftUI
import FirebaseAuth
import Firebase

@main
struct FootballCoachApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            //Show view depending on logged in or not
            if authViewModel.isLoggedIn {
                MainTabView()
                    .environmentObject(authViewModel)
            }
            else {
                LoginView()
                    .environmentObject(authViewModel)
            }
            
        } //End of WindowGroup
    } // End of body
} //End of struct

//
//  AuthViewModel.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine

class AuthViewModel: ObservableObject {
    
    //Variables
    @Published var isLoggedIn: Bool = false
    @Published var teams: [Team] = []
    @Published var selectedTeam: Team?
    @Published var selectedTeamId: String = ""
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    // MARK: Sign in Functions
    init() {
        listenToAuthChanges()
    }

    func listenToAuthChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = (user != nil)
        }
    }
    
    func signIn(email: String, password: String) async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        await MainActor.run {
            self.isLoggedIn = true
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }

    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // MARK: Functions for TEAMS
    
    //Fetch Teams from Firebase
    func fetchTeams() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("teams")
            .whereField("coachIds", arrayContains:uid)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching teams: \(error)")
                    return
                }
                
                do {
                    let fetchedTeams = try snapshot?.documents.compactMap {
                        try $0.data(as: Team.self)
                    } ?? []
                    
                    DispatchQueue.main.async {
                        self.teams = fetchedTeams
                        self.selectedTeam = fetchedTeams.first(where: { $0.id == self.selectedTeamId }) ?? fetchedTeams.first
                        self.selectedTeamId = self.selectedTeam?.id ?? ""
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
                
            }
    }
    
    //Selected Team
    func selectTeam(_ team: Team) {
        selectedTeam = team
        selectedTeamId = team.id ?? ""
    }
            
            
    
}

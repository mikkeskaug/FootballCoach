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
    @Published var name: String = ""
    @Published var players: [Player] = []
    @Published var exercises: [Exercise] = []
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    var currentCoachID: String? {
        Auth.auth().currentUser?.uid
    }
    
    // MARK: Sign in Functions
    
    init() {
        listenToAuthChanges()
    }

    func listenToAuthChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = (user != nil)
            
            if let user = user {
                        Task {
                            await self.loadUserProfileAndTeams(for: user.uid)
                        }
                    }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        await MainActor.run {
            self.isLoggedIn = true
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = Firestore.firestore().collection("users").document(uid)
        let snapshot = try await userRef.getDocument()
        if let data = snapshot.data() {
            self.selectedTeamId = data["selectedTeam"] as? String ?? ""
            self.fetchTeams()
            self.fetchPlayers()
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
    
    // MARK: Load User Profile
    
    func loadUserProfileAndTeams(for uid: String) async {
        let userRef = Firestore.firestore().collection("users").document(uid)
        do {
            let snapshot = try await userRef.getDocument()
            if let data = snapshot.data() {
                await MainActor.run {
                    self.selectedTeamId = data["selectedTeam"] as? String ?? ""
                   
                }
                self.fetchTeams()
                self.fetchPlayers()
            }
        } catch {
            print("Error loading user profile: \(error)")
        }
    }
    
    // MARK: Functions for PLAYERS
    
    func fetchPlayers() {
        guard !selectedTeamId.isEmpty else {
            print("No selected team.")
            return
        }

        Firestore.firestore()
            .collection("teams")
            .document(selectedTeamId)
            .collection("players")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching players: \(error)")
                    return
                }

                do {
                    let fetchedPlayers = try snapshot?.documents.compactMap {
                        try $0.data(as: Player.self)
                    } ?? []
                    DispatchQueue.main.async {
                        self.players = fetchedPlayers
                        
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
    }
    
    func addPlayerToTeam(_ player: Player, to team: Team, completion: @escaping (Bool) -> Void) {
        guard let teamId = team.id else {
            completion(false)
            return
        }

        do {
            _ = try Firestore.firestore()
                .collection("teams")
                .document(teamId)
                .collection("players")
                .addDocument(from: player) { error in
                    if let error = error {
                        print("Error adding player: \(error)")
                        completion(false)
                    } else {
                        self.fetchPlayers()
                        completion(true)
                    }
                }
        } catch {
            print("Encoding error: \(error)")
            completion(false)
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
    
    func addTeam(name: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let teamData: [String: Any] = [
            "name": name,
            "coachIds": [uid]
            // other fields can be added later
        ]

        Firestore.firestore().collection("teams").addDocument(data: teamData) { error in
            if let error = error {
                print("Failed to add team: \(error)")
                completion(false)
            } else {
                self.fetchTeams()
                completion(true)
            }
        }
    }
    
    // MARK: SELECTED TEAM
    
    func saveSelectedTeamToFirestore(_ teamId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).updateData([
            "selectedTeam": teamId
        ])
    }//End func saveSelectedTeamToFirestore
    
    //Selected Team
    func selectTeam(_ team: Team) {
        selectedTeam = team
        selectedTeamId = team.id ?? ""
        saveSelectedTeamToFirestore(selectedTeamId)
        
    }//End Selected Team
    
    // MARK: EXERCISES
    
    func addExercise(name: String, description: String, duration: Int, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let exercise = Exercise(
            id: nil,
            name: name,
            description: description,
            duration: duration,
            createdBy: uid
        )
        
        do
            {
                _ = try Firestore.firestore()
                    .collection("exercises")
                    .addDocument(from: exercise) { error in
                        if let error = error {
                            print("Error adding exercise: \(error)")
                            completion(false)
                        } else {
                            self.fetchExercises()
                            completion(true)
                        }
                    }
                
        }
        catch
        {
            print("Error adding exercise: \(error)")
            completion(false)
        }
        
        
    }//End of addExercise
    
    func fetchExercises() {
        Firestore.firestore().collection("exercises")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching exercises: \(error)")
                    return
                }

                do {
                    let fetched = try snapshot?.documents.compactMap {
                        try $0.data(as: Exercise.self)
                    } ?? []

                    DispatchQueue.main.async {
                        self.exercises = fetched
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
                
            }//End of getDocuments
    } // End fetchExercises
    
}

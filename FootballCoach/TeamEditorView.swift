//
//  TeamEditorView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import SwiftUI

struct TeamEditorView: View {
    
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
    
    @State private var showingAddPlayerDialog = false
    @State var teamname: String = ""
    @State private var newPlayerName = ""
    @State private var newPlayerPosition = ""
    @FocusState private var isNameFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        GroupBox(label: Text("Team Name")) {
                            TextField((authmodel.selectedTeam?.name ?? "Team"), text: $teamname)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            Button(action: {
                                // Add method to edit team name
                            }) {
                                Text("Save")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                        }
                        
                        PlayersView()
                    }
                }
            }
            .navigationTitle("Edit \(authmodel.selectedTeam?.name ?? "Team")")
        }
    }
}

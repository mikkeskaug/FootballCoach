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
    
    @State private var showingAddPlayerSheet = false
    @State var teamname: String = ""
    @State private var newPlayerName = ""
    @State private var newPlayerPosition = ""
    @FocusState private var isNameFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            
                Form {
                    Section(header: Text("Team Name")) {
                        TextField((authmodel.selectedTeam?.name ?? "Team"), text: $teamname)
                        
                        Button(action: {
                            // Add method to edit team name
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(10)
                    
                    }
                    
                    Section(header: Text("Add players")){
                        Button(action: {
                            showingAddPlayerSheet = true
                        }) {
                            Label("Add Player", systemImage: "plus")
                        }
                    }

                    Section(header: Text("Players")) {
                        if authmodel.players.isEmpty {
                    Section() {
                                Text("No players found.")
                                    .foregroundColor(.secondary)
                            }
                        } else {
                    Section() {
                                ForEach(authmodel.players, id: \.id) { player in
                                    VStack(alignment: .leading) {
                                        Text(player.name)
                                            .font(.headline)
                                        if let position = player.position {
                                            Text("Position: \(position)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                            }//End section
                        } // End else
                       

                    }
                }
            
            .navigationTitle("Edit \(authmodel.selectedTeam?.name ?? "Team")")
            .onAppear {
                authmodel.fetchPlayers()
            }
        }
        .sheet(isPresented: $showingAddPlayerSheet) {
            AddPlayerSheet(isPresented: $showingAddPlayerSheet)
                .environmentObject(authmodel)
        }
    }// End of body
}

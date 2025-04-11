//
//  PlayersView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import SwiftUI

struct PlayersView: View {
    
    @EnvironmentObject var authmodel: AuthViewModel
    @State private var showingAddPlayerSheet = false
    
    var body: some View {
        GroupBox(label: Text("Players")) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddPlayerSheet = true
                    }) {
                        Label("Add Player", systemImage: "plus")
                    }
                }

                if authmodel.players.isEmpty {
                    Text("No players found.")
                        .foregroundColor(.secondary)
                } else {
                    List {
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
                    }
                    .listStyle(.insetGrouped)
                    .frame(height: 300)
                }
            }
            .padding()
        }
        .onAppear {
            authmodel.fetchPlayers()
        }
        .sheet(isPresented: $showingAddPlayerSheet) {
            AddPlayerSheet(isPresented: $showingAddPlayerSheet)
                .environmentObject(authmodel)
        }
    }
}

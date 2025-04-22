//
//  TeamSelectorView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import SwiftUI

struct TeamSelectorView: View {
    
    //Variables
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
    @State private var showingAddTeamAlert = false
    @State private var newTeamName = ""
   
    //body view
    var body: some View {
        NavigationView {
            
            List {
                        ForEach(authmodel.teams) { team in
                            HStack {
                                Text(team.name)
                                Spacer()
                                if authmodel.selectedTeam?.id == team.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle()) // makes whole row tappable
                            .onTapGesture {
                                authmodel.selectTeam(team)
                                isPresented = false
                            }
                        }
                    }
                        .onAppear {
                            authmodel.fetchTeams()
                        }
                    .navigationTitle("Velg lag")
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            Button(action: {showingAddTeamAlert = true}) {
                                Label("Add Team", systemImage: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showingAddTeamAlert) {
                        VStack(spacing: 20) {
                            Text("Nytt lag")
                                .font(.headline)

                            TextField("Lagets navn", text: $newTeamName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            HStack {
                                Button("Avbryt") {
                                    showingAddTeamAlert = false
                                    newTeamName = ""
                                }
                                Spacer()
                                Button("Lagre") {
                                    authmodel.addTeam(name: newTeamName) { success in
                                        if success {
                                            newTeamName = ""
                                            showingAddTeamAlert = false
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .presentationDetents([.height(200)])
                    }
                }
        
    }
}

#Preview {
    TeamSelectorView(isPresented: .constant(true))
        .environmentObject(AuthViewModel())
}

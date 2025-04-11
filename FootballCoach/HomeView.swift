//
//  ContentView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authmodel: AuthViewModel
    @State private var showingTeamSelector = false
    @State private var showingTeamEditor = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    GroupBox(label: Text("Welcome to Football Coach!")) {
                        Text("This is a simple app to help you manage your football team.")
                    }
                   
                    
                    
                    GroupBox(label: Text("Manage your team here")){
                        
                        Text("Selected team: \(authmodel.selectedTeam?.name ?? "No team selected")")
                        
                        Button(action: {showingTeamEditor = true}){
                            Text("Update Team Details")
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                }//End of VStack
            }//End of scrollview
            .padding()
            .navigationTitle(Text("Home"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: { showingTeamSelector = true }) {
                        if let team = authmodel.selectedTeam {
                            Label(team.name, systemImage: "person.3.fill")
                        } else {
                            Label("Select Team", systemImage: "person.3.fill")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingTeamSelector) {
                TeamSelectorView(isPresented: $showingTeamSelector)
            }
            .sheet(isPresented: $showingTeamEditor) {
                TeamEditorView(isPresented: $showingTeamEditor)
            }
            
            
        }//End NavigationView
    }//End of body
}//End of struct

#Preview {
    HomeView()
        
        
}

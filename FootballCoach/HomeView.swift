//
//  ContentView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showingTeamSelector = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    GroupBox(label: Text("Welcome to Football Coach!")) {
                        Text("This is a simple app to help you manage your football team.")
                    }
                    Text("Manage your team here")
                        .bold()
                        .padding()
                    
                    List() {
                        Text("Team")
                        Text("Matches")
                        Text("Players")
                    }
                    .background(Color.secondary)
                    
                    
                    
                    
                    Spacer()
                }//End of VStack
            }//End of scrollview
            .padding()
            .navigationTitle(Text("Home"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {showingTeamSelector = true}) {
                        Label("Add Team", systemImage: "person.3.fill")
                    }
                }
            }
            .sheet(isPresented: $showingTeamSelector) {
                TeamSelectorView(isPresented: $showingTeamSelector)
            }
            
            
        }//End NavigationView
    }//End of body
}//End of struct

#Preview {
    HomeView()
}

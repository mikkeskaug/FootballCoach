//
//  TeamSelectorView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import SwiftUI

struct TeamSelectorView: View {
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
   
    
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
                    .navigationTitle("Velg lag")
                }
        
    }
}

#Preview {
    TeamSelectorView(isPresented: .constant(true))
        .environmentObject(AuthViewModel())
}

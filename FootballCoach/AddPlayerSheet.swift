//
//  AddPlayerSheet.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//
import SwiftUI

struct AddPlayerSheet: View {
    
    //Variables
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
    
    @State private var name: String = ""
    @State private var position: String = ""
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Spillerinfo")) {
                    TextField("Navn", text: $name)
                    TextField("Posisjon", text: $position)
                }

                Section {
                    Button("Lagre") {
                        guard let team = authmodel.selectedTeam else {
                            return
                        }
                        let newPlayer = Player(id: nil, name: name, position: position)
                        authmodel.addPlayerToTeam(newPlayer, to: team) { success in
                            if success {
                                isPresented = false
                            } //End if
                        }
                    }//End button
                    .disabled(name.isEmpty)
                }//End section
                
            }//End form
            .navigationTitle("Ny spiller")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") {
                        isPresented = false
                    } //End Button
                    
                } //End toolbaritem
                
            } //End Toolbar
            
        }//End navigationview
    }//End View
} //End struct

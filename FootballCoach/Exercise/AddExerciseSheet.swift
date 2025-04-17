//
//  AddExerciseSheet.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 17/4/25.
//

import SwiftUI

struct AddExerciseSheet: View {
    
    //Variables
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
    
    @State var name: String = ""
    @State var description: String = ""
    @State var duration: Int = 0
    @State var durationText: String = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Exercise info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Duration", text: $durationText)
                        .keyboardType(.numberPad)
                }//End section

                Section {
                    Button("Lagre") {
                        guard let durationValue = Int(durationText),
                              let coachID = authmodel.currentCoachID else { return }
                        let newExercise = Exercise(name: name, description: description, duration: durationValue, createdBy: coachID)
                        authmodel.addExercise(name: name, description: description, duration: durationValue) { success in
                            if success {
                                isPresented = false
                            }
                        }
                    }
                
                } //End Section
                
            }//End form
            .navigationTitle("New Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") {
                        isPresented = false
                    } //End Button
                    
                } //End toolbaritem
                
            } //End Toolbar
            
        }//End navigationview
    }
}

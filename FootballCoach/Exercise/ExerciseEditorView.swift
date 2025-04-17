//
//  ExerciseEditorView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 17/4/25.
//

import SwiftUI

struct ExerciseEditorView: View {
    
    @EnvironmentObject var authmodel: AuthViewModel
    @Binding var isPresented: Bool
    
    @State private var showingAddExerciseDialog = false

    
    var body: some View {
        NavigationView {
           
          
                        ExerciseView(showingAddExerciseSheet: false)
                    
            .navigationTitle("Edit Exercises")
        
            }
            
        
    }// End of body
}

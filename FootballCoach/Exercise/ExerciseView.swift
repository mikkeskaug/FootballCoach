//
//  ExerciseEditorView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 17/4/25.
//

import SwiftUI

struct ExerciseView: View {
    
    //VARIABLES
    @EnvironmentObject var authmodel: AuthViewModel
    @State var showingAddExerciseSheet: Bool
    @State private var searchText: String = ""
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Search")){
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.white)
            }

            if authmodel.exercises.isEmpty {
                Section {
                    Text("No exercises found.")
                        .foregroundColor(.secondary)
                }
            } else {
                Section(header: Text("Exercises")) {
                    ForEach(filteredExercises, id: \.id) { exercise in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(exercise.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text(exercise.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(exercise.duration) min")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .onAppear {
            authmodel.fetchExercises()
        }
        
        .sheet(isPresented: $showingAddExerciseSheet) {
            AddExerciseSheet(isPresented: $showingAddExerciseSheet)
                .environmentObject(authmodel)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddExerciseSheet = true
                }) {
                    Label("Add Exercise", systemImage: "plus")
                }
            }
        }
    }
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return authmodel.exercises
        } else {
            return authmodel.exercises.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
} //End of ExerciseEditorView

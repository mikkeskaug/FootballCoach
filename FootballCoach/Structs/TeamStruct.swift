//
//  TeamStruct.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import Foundation
import FirebaseFirestore

struct Team: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var coachId: [String]?
    var players: [Player]?
    var workouts: [String]?
        
}



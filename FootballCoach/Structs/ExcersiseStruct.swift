//
//  ExcersiseStruct.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 17/4/25.
//

import Foundation
import FirebaseFirestore

struct Exercise: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var duration: Int
    var createdBy: String?
}

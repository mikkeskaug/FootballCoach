//
//  PlayerStruct.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 11/4/25.
//

import Foundation
import FirebaseFirestore

struct Player: Codable, Identifiable{
    @DocumentID var id: String?
    var name: String
    var position: String?
}

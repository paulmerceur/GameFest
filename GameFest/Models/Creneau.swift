//
//  File.swift
//  GameFest
//
//  Created by Paul Merceur on 25/03/2023.
//

import Foundation

struct Creneau: Identifiable, Equatable {
    let id = UUID()
    let date: String
    let horaires: String
    
    init(date: String, horaires: String) {
        self.date = date
        self.horaires = horaires
    }
    
    // Equatable
    static func == (lhs: Creneau, rhs: Creneau) -> Bool {
        return lhs.date == rhs.date &&
               lhs.horaires == rhs.horaires
    }
}

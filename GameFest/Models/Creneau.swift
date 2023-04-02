//
//  File.swift
//  GameFest
//
//  Created by Paul Merceur on 25/03/2023.
//

import Foundation

struct Creneau: Identifiable, Equatable {
    let id: Int
    let date: String
    let heureDebut: String
    let heureFin: String
    
    var horaires: String {
        return "\(heureDebut) - \(heureFin)"
    }
    
    init(id: Int = -1, date: String, heureDebut: String, heureFin: String) {
        self.id = id
        self.date = date
        self.heureDebut = heureDebut
        self.heureFin = heureFin
    }
    
    // Equatable
    static func == (lhs: Creneau, rhs: Creneau) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Creneau: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(heureDebut, forKey: .heureDebut)
        try container.encode(heureFin, forKey: .heureFin)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case heureDebut = "heure_debut"
        case heureFin = "heure_fin"
    }
}

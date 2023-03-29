//
//  Festival.swift
//  GameFest
//
//  Created by Paul Merceur on 25/03/2023.
//

import Foundation

class FestivalModel: Identifiable, ObservableObject {
    let id = UUID()
    let nom: String
    let dateDebut: String
    let dateFin: String
    let creneaux: [Creneau]
    
    init(nom: String, dateDebut: String, dateFin: String, creneaux: [Creneau]) {
        self.nom = nom
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.creneaux = creneaux
    }
    
    init(nom: String, dateDebut: String, dateFin: String, heureDebut: String, heureFin: String) {
        self.nom = nom
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.creneaux = FestivalModel.generateCreneaux(dateDebut: dateDebut, dateFin: dateFin, heureDebut: heureDebut, heureFin: heureFin)
    }
    
    static func generateCreneaux(dateDebut: String, dateFin: String, heureDebut: String, heureFin: String) -> [Creneau] {
        // TODO
        return []
    }
}

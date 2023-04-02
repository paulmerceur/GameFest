//
//  Affectation.swift
//  GameFest
//
//  Created by Paul Merceur on 30/03/2023.
//

import Foundation

struct AffectationJSON: Decodable {
    let id: Int
    let zone: ZoneJSON?
    let creneau: CreneauJSON
    let benevole: BenevoleJSON
    let isDispo: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isDispo = "is_dispo"
        case benevole
        case zone
        case creneau
    }
}

struct ZoneJSON: Decodable {
    let id: Int
    let nom: String
    let festival: Int
    let nbBenevolesMin: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nom
        case festival
        case nbBenevolesMin = "nb_benevoles_min"
    }
}

struct CreneauJSON: Decodable {
    let id: Int
    var date: String
    var heureDebut: String
    var heureFin: String

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case heureDebut = "heure_debut"
        case heureFin = "heure_fin"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(String.self, forKey: .date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date = try container.decode(String.self, forKey: .date)
        if let date = dateFormatter.date(from: self.date) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.date = dateFormatter.string(from: date)
        }

        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        heureDebut = try container.decode(String.self, forKey: .heureDebut)
        if let time = timeFormatter.date(from: heureDebut) {
            timeFormatter.dateFormat = "HH:mm"
            heureDebut = timeFormatter.string(from: time)
        }

        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        heureFin = try container.decode(String.self, forKey: .heureFin)
        if let time = timeFormatter.date(from: heureFin) {
            timeFormatter.dateFormat = "HH:mm"
            heureFin = timeFormatter.string(from: time)
        }

    }
}



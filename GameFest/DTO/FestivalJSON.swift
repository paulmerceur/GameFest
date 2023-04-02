//
//  FestivalJSON.swift
//  GameFest
//
//  Created by Paul Merceur on 31/03/2023.
//

import Foundation

struct FestivalJSON: Decodable {
    let id: Int
    let nom: String
    var dateDebut: String
    var dateFin: String
    var heureDebut: String
    var heureFin: String
    let zones: [ZoneJSON]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nom
        case dateDebut = "date_debut"
        case dateFin = "date_fin"
        case heureDebut = "heure_debut"
        case heureFin = "heure_fin"
        case zones
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        nom = try container.decode(String.self, forKey: .nom)
        zones = try container.decode([ZoneJSON].self, forKey: .zones)
        
        // Update dateDebut and dateFin format
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateDebut = try container.decode(String.self, forKey: .dateDebut)
        if let date = dateFormatter.date(from: dateDebut) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateDebut = dateFormatter.string(from: date)
        }
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFin = try container.decode(String.self, forKey: .dateFin)
        if let date = dateFormatter.date(from: dateFin) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFin = dateFormatter.string(from: date)
        }
        
        // Update heureDebut and heureFin format
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        heureDebut = try container.decode(String.self, forKey: .heureDebut)
        if let time = timeFormatter.date(from: heureDebut) {
            timeFormatter.dateFormat = "HH:mm"
            heureDebut = timeFormatter.string(from: time)
        }
        
        heureFin = try container.decode(String.self, forKey: .heureFin)
        if let time = timeFormatter.date(from: heureFin) {
            timeFormatter.dateFormat = "HH:mm"
            heureFin = timeFormatter.string(from: time)
        }
    }
}

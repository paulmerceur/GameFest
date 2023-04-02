//
//  Festival.swift
//  GameFest
//
//  Created by Paul Merceur on 25/03/2023.
//

import Foundation

protocol FestivalObserver {
    func update(zones: [Zone])
}

class FestivalModel: Identifiable, ObservableObject, Encodable, Decodable {
    public var id: Int
    public var nom: String
    public var dateDebut: String
    public var dateFin: String
    public var heureDebut: String
    public var heureFin: String
    public var creneaux: [Creneau]
    public var zones: [Zone] {
        didSet {
            for o in observers {
                o.update(zones: self.zones)
            }
        }
    }
    
    private var observers : [FestivalObserver] = []
        
    public func register(_ obs: FestivalObserver) {
        self.observers.append(obs)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nom
        case dateDebut
        case dateFin
        case heureDebut
        case heureFin
        case zones
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        nom = try values.decode(String.self, forKey: .nom)
        dateDebut = try values.decode(String.self, forKey: .dateDebut)
        dateFin = try values.decode(String.self, forKey: .dateFin)
        heureDebut = try values.decode(String.self, forKey: .heureDebut)
        heureFin = try values.decode(String.self, forKey: .heureFin)
        creneaux = FestivalModel.generateCreneaux(dateDebut: dateDebut, dateFin: dateFin, heureDebut: heureDebut, heureFin: heureFin)
        zones = try values.decode([Zone].self, forKey: .zones)
    }
    
    init(id: Int? = nil, nom: String, dateDebut: String, dateFin: String, heureDebut: String, heureFin: String, creneaux: [Creneau], zones: [Zone] = []) {
        self.id = id ?? -1
        self.nom = nom
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.heureDebut = heureDebut
        self.heureFin = heureFin
        self.creneaux = creneaux
        self.zones = zones
    }
    
    init(id: Int? = nil, nom: String, dateDebut: String, dateFin: String, heureDebut: String, heureFin: String, zones: [Zone] = []) {
        self.id = id ?? -1
        self.nom = nom
        self.dateDebut = dateDebut
        self.dateFin = dateFin
        self.heureDebut = heureDebut
        self.heureFin = heureFin
        self.creneaux = FestivalModel.generateCreneaux(dateDebut: dateDebut, dateFin: dateFin, heureDebut: heureDebut, heureFin: heureFin)
        self.zones = zones
    }
    
    init(id: Int? = nil, nom: String, dateDebut: Date, dateFin: Date, heureDebut: Date, heureFin: Date, zones: [Zone] = []) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        self.id = id ?? -1
        self.nom = nom
        self.dateDebut = dateFormatter.string(from: dateDebut)
        self.dateFin = dateFormatter.string(from: dateFin)
        self.heureDebut = timeFormatter.string(from: heureDebut)
        self.heureFin = timeFormatter.string(from: heureFin)
        self.creneaux = FestivalModel.generateCreneaux(dateDebut: dateFormatter.string(from: dateDebut), dateFin: dateFormatter.string(from: dateFin), heureDebut: timeFormatter.string(from: heureDebut), heureFin: timeFormatter.string(from: heureFin))
        self.zones = zones
    }
    
    static func generateCreneaux(dateDebut: String, dateFin: String, heureDebut: String, heureFin: String) -> [Creneau] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        guard let start = formatter.date(from: "\(dateDebut) \(heureDebut)"),
              let end = formatter.date(from: "\(dateFin) \(heureFin)"),
              start <= end else {
            return []
        }
        
        var currentDate = start
        var creneaux: [Creneau] = []
        while currentDate <= end {
            let heureDebutCreneau = formatter.string(from: currentDate)
            let heureFinCreneau = formatter.string(from: currentDate.addingTimeInterval(2 * 60 * 60))
            if formatter.date(from: heureFinCreneau) == nil {
                break
            }
            creneaux.append(Creneau(date: formatter.string(from: currentDate), heureDebut: heureDebutCreneau, heureFin: heureFinCreneau))
            currentDate = currentDate.addingTimeInterval(2 * 60 * 60)
        }
        
        return creneaux
    }


}

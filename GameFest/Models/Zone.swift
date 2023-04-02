//
//  Zone.swift
//  GameFest
//
//  Created by Paul Merceur on 31/03/2023.
//

import Foundation

protocol ZoneObserver {
    func update(nom: String)
    func update(nbBenevolesMin: Int)
}

class Zone: Identifiable, Equatable, Decodable, Encodable, Hashable {
    public var id: Int
    public var festival: Int
    public var nom: String {
        didSet {
            for o in observers {
                o.update(nom: self.nom)
            }
        }
    }
    public var nbBenevolesMin: Int {
        didSet {
            for o in observers {
                o.update(nbBenevolesMin: self.nbBenevolesMin)
            }
        }
    }
    
    private var observers : [ZoneObserver] = []
        
    public func register(_ obs: ZoneObserver) {
        self.observers.append(obs)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case festival
        case nom
        case nbBenevolesMin
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        festival = try values.decode(Int.self, forKey: .festival)
        nom = try values.decode(String.self, forKey: .nom)
        nbBenevolesMin = try values.decode(Int.self, forKey: .nbBenevolesMin)
    }
    
    init(id: Int = -1, festival: Int, nom: String, nbBenevolesMin: Int) {
        self.id = id
        self.festival = festival
        self.nom = nom
        self.nbBenevolesMin = nbBenevolesMin
    }
    
    // Equatable
    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



//
//  AffectationModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol AffectationObserver {
    func update(zone: Zone)
    func update(isDispo: Bool)
}

class AffectationModel: Equatable, Hashable, Identifiable {
    public let id: Int
    public var benevole: BenevoleModel
    public var creneau: Creneau
    public var zone: Zone {
        didSet {
            for o in observers {
                o.update(zone: self.zone)
            }
        }
    }
    public var isDispo: Bool {
        didSet {
            for o in observers {
                o.update(isDispo: self.isDispo)
            }
        }
    }
    
    private var observers : [AffectationObserver] = []
        
    public func register(_ obs: AffectationObserver) {
        self.observers.append(obs)
    }
    
    init(id: Int = -1, benevole: BenevoleModel, zone: Zone, creneau: Creneau, isDispo: Bool = false) {
        self.id = id
        self.benevole = benevole
        self.creneau = creneau
        self.isDispo = isDispo
        if isDispo {
            self.zone = zone
        } else {
            self.zone = Zone(festival: -1, nom: "", nbBenevolesMin: 0)
        }
    }
    
    // Equatable
    static func == (lhs: AffectationModel, rhs: AffectationModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AffectationModel: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(benevole, forKey: .benevole)
        try container.encode(creneau, forKey: .creneau)
        try container.encode(zone, forKey: .zone)
        try container.encode(isDispo, forKey: .isDispo)
    }

    private enum CodingKeys: String, CodingKey {
        case benevole
        case creneau
        case zone
        case isDispo
    }
}

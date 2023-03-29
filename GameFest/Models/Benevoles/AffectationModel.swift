//
//  AffectationModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol AffectationObserver {
    func update(zone: String)
    func update(isDispo: Bool)
}

class AffectationModel: Equatable {
    public var creneau: Creneau
    public var zone: String {
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
    
    init(zone: String, creneau: Creneau, isDispo: Bool = false) {
        self.creneau = creneau
        self.isDispo = isDispo
        if isDispo {
            self.zone = zone
        } else {
            self.zone = ""
        }
    }
    
    // Equatable
    static func == (lhs: AffectationModel, rhs: AffectationModel) -> Bool {
        return lhs.creneau == rhs.creneau &&
               lhs.zone == rhs.zone &&
               lhs.isDispo == rhs.isDispo
    }
}

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

class AffectationModel {
    public var date: String
    public var creneau: String
    public var zone: String {
        didSet {
            for o in observers {
                o.update(zone: self.zone)
            }
        }
    }
    public var isDispo: Bool {
        didSet {
            self.zone = ""
            for o in observers {
                o.update(isDispo: self.isDispo)
            }
        }
    }
    
    private var observers : [AffectationObserver] = []
        
    public func register(_ obs: AffectationObserver) {
        self.observers.append(obs)
    }
    
    init(zone: String, date: String, creneau: String, isDispo: Bool = false) {
        self.date = date
        self.creneau = creneau
        self.isDispo = isDispo
        if isDispo {
            self.zone = zone
        } else {
            self.zone = ""
        }
    }
}

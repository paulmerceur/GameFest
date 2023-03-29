//
//  BenevoleModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol BenevoleObserver {
    func update(affectations: [AffectationViewModel])
}

class BenevoleModel: Equatable {
    
    public var prenom: String
    public var nom: String
    public var email: String
    public var isAdmin: Bool
    public var affectations: [AffectationViewModel] {
        didSet {
            for o in observers {
                o.update(affectations: self.affectations)
            }
        }
    }
    
    private var observers : [BenevoleObserver] = []
    public func register(_ obs: BenevoleObserver) {
        self.observers.append(obs)
    }
    
    
    init(prenom: String, nom: String, email: String, isAdmin: Bool, affectations: [AffectationViewModel]) {
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.isAdmin = isAdmin
        self.affectations = affectations
    }
    
    init() {
        self.prenom = ""
        self.nom = ""
        self.email = ""
        self.isAdmin = false
        self.affectations = []
    }
    
    // Equatable
    static func == (lhs: BenevoleModel, rhs: BenevoleModel) -> Bool {
        return lhs.prenom == rhs.prenom &&
               lhs.nom == rhs.nom &&
               lhs.email == rhs.email &&
               lhs.isAdmin == rhs.isAdmin &&
               lhs.affectations == rhs.affectations
    }
}

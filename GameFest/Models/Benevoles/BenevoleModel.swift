//
//  BenevoleModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol BenevoleObserver {
    func update(affectations: [AffectationModel])
}

class BenevoleModel {
    public var prenom: String
    public var nom: String
    public var email: String
    public var affectations: [AffectationModel]
    
    private var observers : [BenevoleObserver] = []
    public func register(_ obs: BenevoleObserver) {
        self.observers.append(obs)
    }
    
    
    init(prenom: String, nom: String, email: String, affectations: [AffectationModel]) {
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.affectations = affectations
    }
    
    init() {
        self.prenom = ""
        self.nom = ""
        self.email = ""
        self.affectations = []
    }
}

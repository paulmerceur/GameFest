//
//  BenevoleViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 26/03/2023.
//

import Foundation

protocol BenevoleVMObserver {
    func vmupdated()
}

class BenevoleViewModel: BenevoleObserver, Identifiable, ObservableObject {
    
    private var model: BenevoleModel
    
    private var observers: [BenevoleVMObserver] = []
    public func register(_ obs: BenevoleVMObserver) {
        self.observers.append(obs)
    }
    
    let id = UUID()
    let prenom: String
    let nom: String
    let email: String
    let isAdmin: Bool
    
    // Published variables
    @Published var affectations: [AffectationViewModel] {
        didSet {
            model.affectations = affectations
            for o in observers { o.vmupdated() }
        }
    }
    
    // Update functions
    func update(affectations: [AffectationViewModel]) {
        if (self.affectations != affectations) {
            self.affectations = affectations
        }
    }
    
    init(model: BenevoleModel) {
        self.model = model
        self.prenom = model.prenom
        self.nom = model.nom
        self.email = model.email
        self.isAdmin = model.isAdmin
        self.affectations = model.affectations
        model.register(self)
    }
}

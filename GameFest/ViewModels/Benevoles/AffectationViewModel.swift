//
//  AffectationModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol AffectationVMObserver {
    func vmupdated()
}

class AffectationViewModel: AffectationObserver, Identifiable, ObservableObject, Equatable {
    private var model: AffectationModel
    
    private var observers: [AffectationVMObserver] = []
    public func register(_ obs: AffectationVMObserver) {
        self.observers.append(obs)
    }
    
    let id = UUID()
    public let creneau: Creneau
    
    // Published variables
    @Published var zone: String {
        didSet {
            model.zone = zone
            for o in observers { o.vmupdated() }
        }
    }
    @Published var isDispo: Bool {
        didSet {
            model.isDispo = isDispo
            for o in observers { o.vmupdated() }
        }
    }
    
    // Update Functions
    func update(zone: String) {
        if (self.zone != zone) {
            self.zone = zone
        }
        // Appel API pour mettre à jour la zone dans la base de données
        // TODO: Implémenter l'appel API
    }
    func update(isDispo: Bool) {
        if (self.isDispo != isDispo) {
            self.isDispo = isDispo
        }
        // Appel API pour mettre à jour la zone dans la base de données
        // TODO: Implémenter l'appel API
    }
    
    init(model: AffectationModel) {
        self.model = model
        self.zone = model.zone
        self.creneau = model.creneau
        self.isDispo = model.isDispo
        model.register(self)
    }
    
    
    // Equatable
    static func == (lhs: AffectationViewModel, rhs: AffectationViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}


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
    
    let id: Int
    public let benevole: BenevoleModel
    public let creneau: Creneau
    
    // Published variables
    @Published var zone: Zone {
        didSet {
            model.zone = zone
            for o in observers { o.vmupdated() }
            self.updateAPI()
        }
    }
    @Published var isDispo: Bool {
        didSet {
            model.isDispo = isDispo
            for o in observers { o.vmupdated() }
            self.updateAPI()
        }
    }
    
    // Update l'affectation dans l'API
    func updateAPI() {
        AffectationRequests.updateAffectation(affectation: self.model) { (error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                print("Affectation updated")
            }
        }
    }

    
    // Update Functions
    func update(zone: Zone) {
        if (self.zone != zone) {
            self.zone = zone
        }
    }
    func update(isDispo: Bool) {
        if (self.isDispo != isDispo) {
            self.isDispo = isDispo
        }
    }
    
    init(model: AffectationModel) {
        self.model = model
        self.id = model.id
        self.benevole = model.benevole
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


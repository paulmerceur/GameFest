//
//  FestivalViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

protocol FestivalVMObserver {
    func vmupdated()
}

class FestivalViewModel: FestivalObserver, Identifiable, ObservableObject, Equatable {
    private var model: FestivalModel
    
    private var observers: [FestivalVMObserver] = []
    public func register(_ obs: FestivalVMObserver) {
        self.observers.append(obs)
    }
    
    public let id: Int
    public let nom: String
    public let dateDebut: String
    public let dateFin: String
    public let heureDebut: String
    public let heureFin: String
    public let creneaux: [Creneau]
    
    // Published variables
    @Published var zones: [Zone] {
        didSet {
            model.zones = zones
            for o in observers { o.vmupdated() }
        }
    }
    
    // Update Functions
    func update(zones: [Zone]) {
        if (self.zones != zones) {
            self.zones = zones
        }
    }
    
    init(model: FestivalModel) {
        self.model = model
        self.id = model.id
        self.nom = model.nom
        self.dateDebut = model.dateDebut
        self.dateFin = model.dateFin
        self.heureDebut = model.heureDebut
        self.heureFin = model.heureFin
        self.creneaux = model.creneaux
        self.zones = model.zones
        model.register(self)
    }
    
    // Equatable
    static func == (lhs: FestivalViewModel, rhs: FestivalViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

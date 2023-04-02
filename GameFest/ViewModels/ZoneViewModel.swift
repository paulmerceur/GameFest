//
//  ZoneViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

protocol ZoneVMObserver {
    func vmupdated()
}

class ZoneViewModel: ZoneObserver, Identifiable, ObservableObject, Equatable {
    private var model: Zone
    
    private var observers: [ZoneVMObserver] = []
    public func register(_ obs: ZoneVMObserver) {
        self.observers.append(obs)
    }
    
    public let id: Int
    
    // Published variables
    @Published var nom: String {
        didSet {
            model.nom = nom
            for o in observers { o.vmupdated() }
        }
    }
    @Published var nbBenevolesMin: Int {
        didSet {
            model.nbBenevolesMin = nbBenevolesMin
            for o in observers { o.vmupdated() }
        }
    }
    
    // Update Functions
    func update(nom: String) {
        if (self.nom != nom) {
            self.nom = nom
        }
    }
    func update(nbBenevolesMin: Int) {
        if (self.nbBenevolesMin != nbBenevolesMin) {
            self.nbBenevolesMin = nbBenevolesMin
        }
    }
    
    init(model: Zone) {
        self.model = model
        self.id = model.id
        self.nom = model.nom
        self.nbBenevolesMin = model.nbBenevolesMin
        model.register(self)
    }
    
    // Equatable
    static func == (lhs: ZoneViewModel, rhs: ZoneViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

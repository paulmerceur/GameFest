//
//  ModifierAffectationViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

class ModifierAffectationViewModel: ObservableObject, AffectationVMObserver {
    @Published var affectationVM: AffectationViewModel
    
    @Published var zones = ["Zone 1", "Zone 2", "Zone 3", "Zone 4", "Zone 5"]
    
    init(affectation: AffectationViewModel) {
        self.affectationVM = affectation
        self.affectationVM.register(self)
    }
    
    func update(zone: String) {
        if self.affectationVM.zone != zone {
            self.affectationVM.zone = zone
            self.objectWillChange.send()
        }
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}

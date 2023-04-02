//
//  ModifierAffectationViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

class ModifierAffectationViewModel: ObservableObject, AffectationVMObserver {
    var festival: FestivalModel
    @Published var affectationVM: AffectationViewModel
    
    @Published var zones: [Zone] = []
    
    init(affectation: AffectationViewModel, festival: FestivalModel) {
        self.affectationVM = affectation
        self.festival = festival
        self.affectationVM.register(self)
        self.getZones()
    }
    
    private func getZones() {
        FestivalRequests.getZones(festivalId: festival.id) { (zones, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                self.zones = zones ?? []
            }
        }
    }
    
    func update(zone: Zone) {
        if self.affectationVM.zone != zone {
            self.affectationVM.zone = zone
            self.objectWillChange.send()
        }
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}

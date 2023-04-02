//
//  ModifierZoneViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class ModifierZoneViewModel: ObservableObject, ZoneVMObserver {
    @Published var zone: ZoneViewModel
    @Published var affectations: [AffectationModel] = []
    @Published var nbBenevolesMin: Int
    
    init(zone: Zone) {
        self.zone = ZoneViewModel(model: zone)
        self.nbBenevolesMin = zone.nbBenevolesMin
        self.getAffectations()
    }
    
    private func getAffectations() {
        ZoneRequests.getAffectations(zoneId: zone.id) { (affectations, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                self.affectations = affectations ?? []
            }
        }
    }
    
    public func updateNbBenevolesMin() {
        self.zone.nbBenevolesMin = self.nbBenevolesMin
    }
    
    func update(nbBenevolesMin: Int) {
        if self.zone.nbBenevolesMin != nbBenevolesMin {
            self.zone.nbBenevolesMin = nbBenevolesMin
            self.objectWillChange.send()
        }
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}

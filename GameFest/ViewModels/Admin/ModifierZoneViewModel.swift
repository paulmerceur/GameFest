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
        ZoneRequests.getAffectations(zoneId: self.zone.id) { (affectations, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                if !affectations!.isEmpty {
                    return
                }
            }
        }
    }
    
    public func updateNbBenevolesMin() {
        self.zone.nbBenevolesMin = self.nbBenevolesMin
        self.updateAPI()
    }
    
    func update(nbBenevolesMin: Int) {
        if self.zone.nbBenevolesMin != nbBenevolesMin {
            self.zone.nbBenevolesMin = nbBenevolesMin
            self.objectWillChange.send()
        }
    }
    
    func updateAPI() {
        ZoneRequests.updateZone(zone: self.zone.model) { (error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                print("Zone updated")
            }
        }
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}

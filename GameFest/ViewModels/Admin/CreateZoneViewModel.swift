//
//  CreateZoneViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class CreateZoneViewModel: ObservableObject {
    @Published var nom: String = ""
    @Published var nbBenevolesMin = 0
    
    private var festival: FestivalViewModel
    
    init(festival: FestivalModel) {
        self.festival = FestivalViewModel(model: festival)
    }

    func createZone() {
        let zone = Zone(nom: nom, nbBenevolesMin: nbBenevolesMin)

        ZoneRequests.createZone(zone: zone, festivalId: festival.id) { (zone, error) in
            if let error = error {
                print("Erreur lors de la création de festival: \(error.localizedDescription)")
            } else {
                self.festival.zones.append(zone!)
            }
        }
    }

}

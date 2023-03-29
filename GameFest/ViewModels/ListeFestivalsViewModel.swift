//
//  ListeFestivalsViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 26/03/2023.
//

import Foundation

class ListeFestivalsViewModel: ObservableObject {
    @Published var festivals: [FestivalModel] = []
    @Published var benevole: BenevoleModel
    
    init(benevole: BenevoleModel) {
        // Charger les données des festivals ici
        // TODO: Implémenter la récupération des festivals via l'API
        // TODO: Vérifier à quels festivals le bénévole a accès
        self.benevole = benevole
        loadSampleData()
    }
    
    private func loadSampleData() {
        let creneaux1 = [
            Creneau(date: "2023-04-20", horaires: "10:00 - 12:00"),
            Creneau(date: "2023-04-20", horaires: "14:00 - 16:00"),
            Creneau(date: "2023-04-21", horaires: "10:00 - 12:00")
        ]
        
        let creneaux2 = [
            Creneau(date: "2023-05-10", horaires: "10:00 - 12:00"),
            Creneau(date: "2023-05-11", horaires: "14:00 - 16:00"),
            Creneau(date: "2023-05-12", horaires: "10:00 - 12:00")
        ]
        
        let festival1 = FestivalModel(nom: "Festival1", dateDebut: "2023-04-20", dateFin: "2023-04-21", creneaux: creneaux1)
        let festival2 = FestivalModel(nom: "Festival2", dateDebut: "2023-05-10", dateFin: "2023-05-12", creneaux: creneaux2)
        
        self.festivals = [festival1, festival2]
    }
}

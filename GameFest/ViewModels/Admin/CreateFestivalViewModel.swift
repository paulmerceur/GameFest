//
//  CreateFestivalViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class CreateFestivalViewModel: ObservableObject {
    @Published var nom: String = ""
    @Published var dateDebut: Date = Date()
    @Published var dateFin: Date = Date()
    @Published var heureDebut: Date = Date()
    @Published var heureFin: Date = Date()
    
    private var listeFestivals: ListeFestivalsViewModel
    
    init(listeFestivals: ListeFestivalsViewModel) {
        self.listeFestivals = listeFestivals
    }

    func createFestival() {
        self.listeFestivals.addFestival(festival: FestivalModel(nom: self.nom, dateDebut: self.dateDebut, dateFin: self.dateFin, heureDebut: self.heureDebut, heureFin: self.heureFin))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        let dateStringDebut = dateFormatter.string(from: dateDebut)
        let dateStringFin = dateFormatter.string(from: dateFin)
        let heureStringDebut = timeFormatter.string(from: heureDebut)
        let heureStringFin = timeFormatter.string(from: heureFin)

        let festival = FestivalModel(nom: nom, dateDebut: dateStringDebut, dateFin: dateStringFin, heureDebut: heureStringDebut, heureFin: heureStringFin)

        FestivalRequests.createFestival(festival: festival) { (festival, error) in
            if let error = error {
                print("Erreur lors de la création de festival: \(error.localizedDescription)")
            } else {
                let festival: FestivalModel = festival!
                let creneaux = festival.creneaux
                print("Créneaux: \(creneaux)")
//                FestivalRequests.createCreneauxForFestival(id: festival.id, creneaux: creneaux) { (error) in
//                    if let error = error {
//                        print("Erreur lors de la création des créneaux du festival: \(error.localizedDescription)")
//                    } else {
//                        print("Festival et créneaux créés")
//                    }
//                }
            }
        }
    }

}

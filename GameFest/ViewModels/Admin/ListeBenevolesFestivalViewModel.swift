//
//  ListeBenevolesFestivalViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class ListeBenevolesFestivalViewModel: ObservableObject {
    public var festival: FestivalViewModel
    
    @Published var benevoles: [BenevoleModel] = []
    @Published var benevolesParticipant: [BenevoleModel] = []
    @Published var benevolesNonParticipant: [BenevoleModel] = []

    init(festival: FestivalModel) {
        self.festival = FestivalViewModel(model: festival)
        self.getBenevoles()
    }
    
    func getBenevoles() {
        // Get bénévoles participants
        FestivalRequests.getBenevoles(festivalId: festival.id) { (benevoles, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                self.benevolesParticipant = benevoles ?? []
            }
        }
        
        // Get all bénévoles
        BenevoleRequests.getAllBenevoles() { (benevoles, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                self.benevoles = benevoles ?? []
            }
        }
        
        // Create benevolesNonParticipant array
        for benevole in self.benevoles {
            if !self.benevolesParticipant.contains(benevole) {
                self.benevolesNonParticipant.append(benevole)
            }
        }
    }
    
    func addBenevole(_ benevole: BenevoleModel) {
        print("Adding Benevole")
        if let index = self.benevolesNonParticipant.firstIndex(of: benevole) {
            print("Benevole Removed")
            benevolesNonParticipant.remove(at: index)
        }
        print("Benevole added")
        self.benevolesParticipant.append(benevole)
        
        FestivalRequests.addBenevoleToFestival(benevoleId: benevole.id, festivalId: self.festival.id) { (error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                print("Benevole added to festival on API")
            }
        }
    }
}

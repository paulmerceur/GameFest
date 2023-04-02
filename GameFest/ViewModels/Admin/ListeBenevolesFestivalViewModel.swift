//
//  ListeBenevolesFestivalViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class ListeBenevolesFestivalViewModel: ObservableObject {
    public var festival: FestivalViewModel
    
    @Published var benevoles: [BenevoleViewModel] = []
    
    init(festival: FestivalModel) {
        self.festival = FestivalViewModel(model: festival)
        self.getBenevoles()
    }
    
    func getBenevoles() {
        FestivalRequests.getBenevoles(festivalId: festival.id) { (benevoles, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                let benevolesModels = benevoles ?? []
            }
        }
    }
}

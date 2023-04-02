//
//  BenevoleDashboardViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation
import SwiftUI

class BenevoleDashboardViewModel: ObservableObject {
    @Published var isLoggedOut: Bool = false
    
    @ObservedObject var affectationsVM = AffectationListViewModel()
    @Published var benevole: BenevoleModel
    var festival: FestivalModel
    
    init(benevole: BenevoleModel, festival: FestivalModel) {
        self.benevole = benevole
        self.festival = festival
        self.getAffectations()
    }
    
    func getAffectations() {
        BenevoleRequests.getAffectations(benevoleId: self.benevole.id, festivalId: self.festival.id) { (affectations, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                let affectations = affectations ?? []
                self.affectationsVM = AffectationListViewModel(affectations: affectations)
            }
        }
    }
    
    func logout() {
        AuthRequests.logout()
        self.isLoggedOut = true
    }
    
    
}

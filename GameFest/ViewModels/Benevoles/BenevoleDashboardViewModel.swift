//
//  BenevoleDashboardViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation
import SwiftUI

class BenevoleDashboardViewModel: ObservableObject, BenevoleObserver {
    @Published var isLoggedOut: Bool = false
    
    @ObservedObject var affectationsVM: AffectationListViewModel
    @Published var benevole: BenevoleModel
    
    // Update Functions
    func update(affectations: [AffectationModel]) {
        self.benevole.affectations = affectations
        self.objectWillChange.send()
    }
    
    init(benevole: BenevoleModel) {
        self.affectationsVM = AffectationListViewModel(affectations: benevole.affectations)
        self.benevole = benevole
    }
    
    func logout() {
        guard let url = URL(string: "https://festivals-api.onrender.com/auth/logout/") else {
            print("Invalid URL")
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            self.isLoggedOut = true
        } catch {
            print("Erreur pendant tentative de déconnexion")
        }
    }
}

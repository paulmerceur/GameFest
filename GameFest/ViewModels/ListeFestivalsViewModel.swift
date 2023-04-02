//
//  ListeFestivalsViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 26/03/2023.
//

import Foundation

class ListeFestivalsViewModel: ObservableObject {
    @Published var isLoggedOut: Bool = false
    
    @Published var festivals: [FestivalModel] = []
    @Published var benevole: BenevoleModel
    
    init(benevole: BenevoleModel) {
        self.benevole = benevole
        getFestivals()
    }
    
    private func getFestivals() {
        BenevoleRequests.getFestivals(benevoleId: benevole.id, isAdmin: self.benevole.isAdmin) { (festivals, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
            } else {
                self.festivals = festivals ?? []
            }
        }
    }
    
    public func addFestival(festival: FestivalModel) {
        self.festivals.append(festival)
    }
    
    func logout() {
        AuthRequests.logout()
        self.isLoggedOut = true
    }
}

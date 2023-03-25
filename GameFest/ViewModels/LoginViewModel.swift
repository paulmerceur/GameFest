//
//  LoginViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 18/03/2023.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isLoggedIn: Bool = false
    @Published var isAdmin: Bool = false
    
    @Published var benevole: BenevoleModel
    private var affectations = [
        AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "10:00 - 12:00", isDispo: true),
        AffectationModel(zone: "Zone 2", date: "2023-03-21", creneau: "10:00 - 12:00", isDispo: false),
        AffectationModel(zone: "Zone 3", date: "2023-03-19", creneau: "10:00 - 12:00", isDispo: true),
        AffectationModel(zone: "Zone 2", date: "2023-03-20", creneau: "12:00 - 14:00", isDispo: true),
        AffectationModel(zone: "Zone 1", date: "2023-03-21", creneau: "12:00 - 14:00", isDispo: false),
        AffectationModel(zone: "Zone 4", date: "2023-03-19", creneau: "12:00 - 14:00", isDispo: true),
        AffectationModel(zone: "Zone 4", date: "2023-03-22", creneau: "10:00 - 12:00", isDispo: true),
        AffectationModel(zone: "Zone 3", date: "2023-03-20", creneau: "14:00 - 16:00", isDispo: true),
        AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "16:00 - 18:00", isDispo: true),
    ]

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.benevole = BenevoleModel()
    }

    // Login function
    func login() {
        AuthRequests.login(email: email, password: password) { result in
            switch result {
            case .success(let decodedResponse):
                DispatchQueue.main.async {
                    self.isAdmin = decodedResponse.session.user.role == "admin"
                    self.isLoggedIn = true
                    self.benevole.prenom = "Paco"
                    self.benevole.nom = "Gangsta"
                    self.benevole.email = "paco@gangsta.com"
                    self.benevole.affectations = self.affectations
                }
            case .failure(let error):
                print("Erreur de connexion : \(error)")
            }
        }
    }
}

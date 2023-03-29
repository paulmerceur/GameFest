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
    
    @Published var benevole: BenevoleModel
    private var affectations = [
        AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-20", horaires: "10:00 - 12:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 2", creneau: Creneau(date: "2023-03-21", horaires: "10:00 - 12:00"), isDispo: false)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 3", creneau: Creneau(date: "2023-03-19", horaires: "10:00 - 12:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 2", creneau: Creneau(date: "2023-03-20", horaires: "12:00 - 14:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-21", horaires: "12:00 - 14:00"), isDispo: false)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 4", creneau: Creneau(date: "2023-03-19", horaires: "12:00 - 14:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 4", creneau: Creneau(date: "2023-03-22", horaires: "10:00 - 12:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 3", creneau: Creneau(date: "2023-03-20", horaires: "14:00 - 16:00"), isDispo: true)),
        AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-20", horaires: "16:00 - 18:00"), isDispo: true)),
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
                self.errorMessage = ""
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.benevole.prenom = decodedResponse.user_infos.prenom
                    self.benevole.nom = decodedResponse.user_infos.nom
                    self.benevole.email = decodedResponse.session.user.email
                    self.benevole.isAdmin = decodedResponse.session.user.role == "admin"
                    self.benevole.affectations = self.affectations
                }
            case .failure(let error):
                self.errorMessage = "Identifiants incorrects"
                print("Erreur de connexion : \(error)")
            }
        }
    }
}

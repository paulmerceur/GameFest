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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.benevole = BenevoleModel()
    }
    
    // Login function
    func login() {
        // Connecte l'utilisateur
        AuthRequests.login(email: email, password: password) { result in
            switch result {
            case .success(let decodedResponse):
                DispatchQueue.main.async {
                    self.errorMessage = ""
                    self.isLoggedIn = true
                    self.benevole.id = decodedResponse.session.user.id
                    self.benevole.prenom = decodedResponse.user_infos.prenom
                    self.benevole.nom = decodedResponse.user_infos.nom
                    self.benevole.email = decodedResponse.session.user.email
                    self.benevole.isAdmin = decodedResponse.session.user.role == "admin"
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Identifiants incorrects"
                }
                print("Erreur de connexion : \(error)")
            }
        }
    }
}


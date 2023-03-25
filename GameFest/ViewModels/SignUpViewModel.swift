//
//  SignUpViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 18/03/2023.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var isSignedUp = false
    @Published var message = ""
    
    private var cancellables = Set<AnyCancellable>()

    func signUp() {
        AuthRequests.signUp(email: email, password: password) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isSignedUp = true
                    self.message = "Inscription réussie. Veuillez confirmer votre email."
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isSignedUp = false
                    self.message = "Erreur d'inscription : \(error)"
                }
            }
        }
    }

}

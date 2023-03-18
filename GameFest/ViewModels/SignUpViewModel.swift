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
        guard let url = URL(string: "https://festivals-api.onrender.com/auth/register/") else {
            print("URL invalide")
            return
        }

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        let requestBody = try? JSONEncoder().encode(parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    // Afficher le contenu de `data` en tant que chaîne
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON reçu : \(jsonString)")
                    }
                    
                    let decodedResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                    

                    if decodedResponse.error == nil {
                        DispatchQueue.main.async {
                            self.isSignedUp = true
                            self.message = "Inscription réussie. Veuillez confirmer votre email."
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.isSignedUp = false
                            self.message = "Erreur d'inscription : \(decodedResponse.error!)"
                        }
                    }
                } catch {
                    print("Erreur de décodage : \(error)")
                }
            } else {
                print("Erreur de requête : \(error?.localizedDescription ?? "Aucune donnée")")
            }
        }.resume()
    }

}

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

    private var cancellables = Set<AnyCancellable>()

    func login() {
        guard let url = URL(string: "https://festivals-api.onrender.com/auth/login/") else {
            print("Invalid URL")
            return
        }

        let loginData = [
            "email": email,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

                        if decodedResponse.error == nil {
                            DispatchQueue.main.async {
                                self.isLoggedIn = true
                            }
                        } else {
                            print("Erreur de connexion : \(decodedResponse.error!)")
                        }
                    } catch {
                        print("Erreur de décodage : \(error)")
                    }
                } else {
                    print("Erreur de requête : \(error?.localizedDescription ?? "Aucune donnée")")
                }
            }.resume()
        } catch {
            print("Error encoding JSON")
        }
    }
}

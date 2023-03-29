//
//  AuthRequests.swift
//  GameFest
//
//  Created by Paul Merceur on 25/03/2023.
//

import Foundation

class AuthRequests {

    static func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
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

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

                        if decodedResponse.error == nil {
                            completion(.success(decodedResponse))
                        } else {
                            completion(.failure(APIError.serverError(decodedResponse.error!)))
                        }
                    } catch {
                        completion(.failure(APIError.decodingError(error)))
                    }
                } else {
                    completion(.failure(APIError.requestError(error!)))
                }
            }.resume()
        } catch {
            completion(.failure(APIError.encodingError(error)))
        }
    }
    
    static func signUp(email: String, password: String, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
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
                        let decodedResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)

                        if decodedResponse.error == nil {
                            completion(.success(decodedResponse))
                        } else {
                            completion(.failure(APIError.serverError(decodedResponse.error!)))
                        }
                    } catch {
                        completion(.failure(APIError.decodingError(error)))
                    }
                } else {
                    completion(.failure(APIError.requestError(error!)))
                }
            }.resume()
        }

}

enum APIError: Error {
    case serverError(String)
    case decodingError(Error)
    case encodingError(Error)
    case requestError(Error)
}



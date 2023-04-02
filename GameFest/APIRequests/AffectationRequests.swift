//
//  AffectationRequests.swift
//  GameFest
//
//  Created by Paul Merceur on 02/04/2023.
//

import Foundation

class AffectationRequests {
    
    // Update affectation
    static func updateAffectation(affectation: AffectationModel, completion: @escaping (Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/affectations/\(affectation.id)"
        guard let url = URL(string: urlString) else {
            completion(NSError(domain: "No data returned", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyDict: [String: Any?] = [
            "id": affectation.id,
            "is_dispo": affectation.isDispo,
            "benevole": affectation.benevole.id,
            "creneau": affectation.creneau.id,
            "zone": affectation.zone.id
        ]
        do {
            let data = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
            request.httpBody = data
        } catch {
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(NSError(domain: "Invalid Response", code: 0, userInfo: nil))
                return
            }
            if response.statusCode == 200 {
                print("Update successful")
            } else {
                print("Update failed with status code: \(response.statusCode)")
            }
        }.resume()
    }
}

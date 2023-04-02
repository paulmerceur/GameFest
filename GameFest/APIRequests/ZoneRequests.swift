//
//  ZoneRequests.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class ZoneRequests {
    
    // Get affectations for a festival
    static func getAffectations(zoneId: Int, completion: @escaping ([AffectationModel]?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/zones/\(zoneId)/affectations"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        print("1")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("2")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("3")
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No data returned", code: 0, userInfo: nil))
                return
            }
            print("Request data: \(String(data: data, encoding: .utf8) ?? "")")
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let affectations = try jsonDecoder.decode([AffectationJSON].self, from: data)
                print("Affectations: \(affectations)")
                let affectationsModels = affectations.map {
                    AffectationModel(
                        id: $0.id,
                        benevole: BenevoleModel(
                            id: $0.benevole.id,
                            prenom: $0.benevole.prenom,
                            nom: $0.benevole.nom,
                            email: $0.benevole.email,
                            isAdmin: $0.benevole.isAdmin
                        ),
                        zone: $0.zone != nil ? Zone(
                            id: $0.zone!.id,
                            festival: $0.zone!.festival,
                            nom: $0.zone!.nom,
                            nbBenevolesMin: $0.zone!.nbBenevolesMin
                        ) : Zone(
                            festival: -1,
                            nom: "",
                            nbBenevolesMin: 0
                        ),
                        creneau: Creneau(
                            date: $0.creneau.date,
                            heureDebut: $0.creneau.heureDebut,
                            heureFin: $0.creneau.heureFin
                        ),
                        isDispo: $0.isDispo
                    )
                }
                completion(affectationsModels, nil)
                print("Good")
                if !affectationsModels.isEmpty {
                    return
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // Create a zone
    static func createZone(zone: Zone, completion: @escaping (Zone?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/zones"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var bodyDict: [String: Any] = [:]
        bodyDict["nom"] = zone.nom
        bodyDict["festival"] = zone.festival
        bodyDict["nb_benevoles_min"] = zone.nbBenevolesMin
    

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
            request.httpBody = jsonData
        } catch {
            completion(nil, error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No data returned", code: 0, userInfo: nil))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let zoneJSON = try jsonDecoder.decode(ZoneJSON.self, from: data)
                let zone = Zone(id: zoneJSON.id, festival: zoneJSON.festival, nom: zoneJSON.nom, nbBenevolesMin: zoneJSON.nbBenevolesMin)
                
                completion(zone, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // Update zone
    static func updateZone(zone: Zone, completion: @escaping (Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/zones/\(zone.id)"
        guard let url = URL(string: urlString) else {
            completion(NSError(domain: "No data returned", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyDict: [String: Any] = [
            "nom": zone.nom,
            "festival": zone.festival,
            "nb_benevoles_min": zone.nbBenevolesMin
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

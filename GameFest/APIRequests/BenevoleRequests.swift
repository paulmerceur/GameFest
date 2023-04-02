//
//  BenevoleRequests.swift
//  GameFest
//
//  Created by Paul Merceur on 30/03/2023.
//

import Foundation

class BenevoleRequests {
    
    static func getAffectations(benevoleId: String, festivalId: Int, completion: @escaping ([AffectationViewModel]?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/benevoles/\(benevoleId)/festivals/\(festivalId)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
                jsonDecoder.dateDecodingStrategy = .iso8601
                let affectations = try jsonDecoder.decode([AffectationJSON].self, from: data)
                let affectationViewModels = affectations.map {
                    AffectationViewModel(model: AffectationModel(
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
                            nom: $0.zone!.nom,
                            nbBenevolesMin: $0.zone!.nbBenevolesMin
                        ) : Zone(
                            nom: "",
                            nbBenevolesMin: 0
                        ),
                        creneau: Creneau(
                            id: $0.creneau.id,
                            date: $0.creneau.date,
                            heureDebut: $0.creneau.heureDebut,
                            heureFin: $0.creneau.heureFin
                        ),
                        isDispo: $0.isDispo
                    ))
                }
                completion(affectationViewModels, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    
    static func getFestivals(benevoleId: String, isAdmin: Bool = false, completion: @escaping ([FestivalModel]?, Error?) -> Void) {
        let urlString: String
        if isAdmin {
            urlString = "https://festivals-api.onrender.com/festivals"
        } else {
            urlString = "https://festivals-api.onrender.com/benevoles/\(benevoleId)/festivals"
        }
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
                jsonDecoder.dateDecodingStrategy = .iso8601
                let festivals = try jsonDecoder.decode([FestivalJSON].self, from: data)
                
                let festivalsModels = festivals.map { FestivalModel(id: $0.id, nom: $0.nom, dateDebut: $0.dateDebut, dateFin: $0.dateFin, heureDebut: $0.heureDebut, heureFin: $0.heureFin, creneaux: [], zones: $0.zones.map { Zone(id: $0.id, nom: $0.nom, nbBenevolesMin: $0.nbBenevolesMin) }) }
                completion(festivalsModels, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // Get all bénévoles
    static func getAllBenevoles(completion: @escaping ([BenevoleModel]?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/benevoles"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    let benevoles = try jsonDecoder.decode([BenevoleJSON].self, from: data)
                    let benevolesModels = benevoles.map { BenevoleModel(id: $0.id, prenom: $0.prenom, nom: $0.nom, email: $0.email, isAdmin: $0.isAdmin) }
                    completion(benevolesModels, nil)
                } catch {
                    completion(nil, error)
                }
        }.resume()
    }
}

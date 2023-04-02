//
//  FestivalRequests.swift
//  GameFest
//
//  Created by Paul Merceur on 31/03/2023.
//

import Foundation

class FestivalRequests {
    
    // Get zones for a festival
    static func getZones(festivalId: Int, completion: @escaping ([Zone]?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/festivals/\(festivalId)/zones"
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
                let zones = try jsonDecoder.decode([ZoneJSON].self, from: data)
                let zonesModels = zones.map { Zone(id: $0.id, nom: $0.nom, nbBenevolesMin: $0.nbBenevolesMin) }
                completion(zonesModels, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // Create a festival
    static func createFestival(festival: FestivalModel, completion: @escaping (FestivalModel?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/festivals"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        print("Creating festival...")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
            
        var bodyDict: [String: Any] = [:]
        bodyDict["nom"] = festival.nom
        bodyDict["date_debut"] = dateFormatter.date(from: festival.dateDebut)?.iso8601DateString
        bodyDict["date_fin"] = dateFormatter.date(from: festival.dateFin)?.iso8601DateString
        bodyDict["heure_debut"] = timeFormatter.date(from: festival.heureDebut)?.timeString
        bodyDict["heure_fin"] = timeFormatter.date(from: festival.heureFin)?.timeString
        
        print("Body Dict: \(bodyDict)")
        
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
            print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let festivalJSON = try jsonDecoder.decode(FestivalJSON.self, from: data)
                print("FestivalJSON: \(festivalJSON)")
                let festival = FestivalModel(nom: festivalJSON.nom, dateDebut: festivalJSON.dateDebut, dateFin: festivalJSON.dateFin, heureDebut: festivalJSON.heureDebut, heureFin: festivalJSON.heureFin)
                print("FestivalModelCreneaux: \(festival.creneaux)")
                completion(festival, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }


    // Add the Creneaux to the festival
    static func createCreneauxForFestival(id: Int, creneaux: [Creneau], completion: @escaping (Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/festivals/\(id)/creneaux"
        guard let url = URL(string: urlString) else {
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var requestBody = "["
        for (index, creneau) in creneaux.enumerated() {
            let creneauJson = """
            {"date": "\(creneau.date)",
            "heure_debut": "\(creneau.heureDebut)","
            "heure_fin": "\(creneau.heureFin)"}
            """
            requestBody += creneauJson
            if index < creneaux.count - 1 {
                requestBody += ","
            }
        }
        requestBody += "]"
        
        guard let jsonData = requestBody.data(using: .utf8) else {
            completion(NSError(domain: "Invalid JSON data", code: 0, userInfo: nil))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(NSError(domain: "Invalid response", code: 0, userInfo: nil))
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    // Get all the benevoles from a festival
    static func getBenevoles(festivalId: Int, completion: @escaping ([BenevoleModel]?, Error?) -> Void) {
        let urlString = "https://festivals-api.onrender.com/festivals/\(festivalId)/benevoles"
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


extension Date {
    var iso8601DateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }
    var iso8601String: String {
        return Formatter.iso8601.string(from: self)
    }
    var timeString: String {
            return Formatter.time.string(from: self)
        }
    }

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}

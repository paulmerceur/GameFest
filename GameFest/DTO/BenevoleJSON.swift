//
//  BenevoleJSON.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

struct BenevoleJSON: Decodable {
    let id: String
    let prenom: String
    let nom: String
    let email: String
    var isAdmin: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case prenom
        case nom
        case email
        case role
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        prenom = try container.decode(String.self, forKey: .prenom)
        nom = try container.decode(String.self, forKey: .nom)
        email = try container.decode(String.self, forKey: .email)
        let role = try container.decode(String.self, forKey: .role)
        isAdmin = role == "admin"

    }
}

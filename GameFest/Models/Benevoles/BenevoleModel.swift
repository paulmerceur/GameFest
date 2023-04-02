//
//  BenevoleModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation

protocol BenevoleObserver {
}

class BenevoleModel: Equatable, Hashable, Encodable, Identifiable {
    
    public var id: String
    public var prenom: String
    public var nom: String
    public var email: String
    public var isAdmin: Bool
    
    private var observers : [BenevoleObserver] = []
    public func register(_ obs: BenevoleObserver) {
        self.observers.append(obs)
    }
    
    
    init(id: String, prenom: String, nom: String, email: String, isAdmin: Bool) {
        self.id = id
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.isAdmin = isAdmin
    }
    
    init() {
        self.id = ""
        self.prenom = ""
        self.nom = ""
        self.email = ""
        self.isAdmin = false
    }
    
    // Encodable
    enum CodingKeys: String, CodingKey {
        case id
        case prenom
        case nom
        case email
        case isAdmin
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        prenom = try values.decode(String.self, forKey: .prenom)
        nom = try values.decode(String.self, forKey: .nom)
        email = try values.decode(String.self, forKey: .email)
        isAdmin = try values.decode(Bool.self, forKey: .isAdmin)
    }
    
    // Equatable
    static func == (lhs: BenevoleModel, rhs: BenevoleModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

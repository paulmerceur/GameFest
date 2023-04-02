//
//  SignUpResponse.swift
//  GameFest
//
//  Created by Paul Merceur on 18/03/2023.
//

import Foundation

struct SignUpResponse: Codable {
    let user: User
    let session: Session?
    let error: String?

    struct User: Codable {
        let id: String
        let aud: String
        let role: String
        let email: String
        let phone: String
        let confirmation_sent_at: String
        let app_metadata: AppMetadata
        let user_metadata: [String: String]
        let identities: [Identity]
        let created_at: String
        let updated_at: String
        let nom: String
        let prenom: String
    }

    struct AppMetadata: Codable {
        let provider: String
        let providers: [String]
    }

    struct Identity: Codable {
        let id: String
        let user_id: String
        let identity_data: IdentityData
        let provider: String
        let last_sign_in_at: String
        let created_at: String
        let updated_at: String
    }

    struct IdentityData: Codable {
        let email: String
        let sub: String
    }

    struct Session: Codable {
        let access_token: String
        let token_type: String
        let expires_in: Int
        let refresh_token: String
    }
}

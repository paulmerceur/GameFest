//
//  LoginResponse.swift
//  GameFest
//
//  Created by Paul Merceur on 18/03/2023.
//

import Foundation

struct LoginResponse: Codable {
    let session: Session
    let user_infos: UserInfos
    let error: String?

    struct Session: Codable {
        let accessToken: String
        let tokenType: String
        let expiresIn: Int
        let refreshToken: String
        let user: User
        let expiresAt: Int

        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case expiresIn = "expires_in"
            case refreshToken = "refresh_token"
            case user
            case expiresAt = "expires_at"
        }
    }

    struct User: Codable {
        let id: String
        let aud: String
        let role: String
        let email: String
        let emailConfirmedAt: String
        let phone: String
        let confirmationSentAt: String
        let confirmedAt: String
        let lastSignInAt: String
        let appMetadata: AppMetadata
        let userMetadata: [String: String]
        let identities: [Identity]
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case aud
            case role
            case email
            case emailConfirmedAt = "email_confirmed_at"
            case phone
            case confirmationSentAt = "confirmation_sent_at"
            case confirmedAt = "confirmed_at"
            case lastSignInAt = "last_sign_in_at"
            case appMetadata = "app_metadata"
            case userMetadata = "user_metadata"
            case identities
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct UserInfos: Codable {
        let nom: String
        let prenom: String
        
        enum CodingKeys: String, CodingKey {
            case nom
            case prenom
        }
    }

    struct AppMetadata: Codable {
        let provider: String
        let providers: [String]
    }

    struct Identity: Codable {
        let id: String
        let userId: String
        let identityData: IdentityData
        let provider: String
        let lastSignInAt: String
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case userId = "user_id"
            case identityData = "identity_data"
            case provider
            case lastSignInAt = "last_sign_in_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

    struct IdentityData: Codable {
        let email: String
        let sub: String
    }
}

//
//  FirebaseJWTPayload.swift
//  FirebaseJWTMiddleware
//
//  Created by Baris Atamer on 23.08.19.
//

import JWT

struct FirebaseJWTPayload: JWTPayload {
    var issuer: IssuerClaim
    var issuedAt: IssuedAtClaim
    var expirationAt: ExpirationClaim
    var email: String
    var userID: String
    
    var picture: String?
    var name: String?
    var authTime: Date?
    var isEmailVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case issuedAt = "iat"
        case expirationAt = "exp"
        case email = "email"
        case userID = "user_id"
        case picture = "picture"
        case name = "name"
        case authTime = "auth_time"
        case isEmailVerified = "email_verified"
    }
    
    func verify(using signer: JWTSigner) throws {
        guard self.issuer.value == FirebaseJWTMiddlewareConfig.shared.issuer else {
            throw JWTError.verificationFailed
        }
        try self.expirationAt.verifyNotExpired()
    }
}

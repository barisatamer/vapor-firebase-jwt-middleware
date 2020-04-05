//
//  FirebaseJWTPayload.swift
//  FirebaseJWTMiddleware
//
//  Created by Baris Atamer on 23.08.19.
//

import JWT

public struct FirebaseJWTPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case subject = "sub"
        case audience = "aud"
        case issuedAt = "iat"
        case expirationAt = "exp"
        case email = "email"
        case userID = "user_id"
        case picture = "picture"
        case name = "name"
        case authTime = "auth_time"
        case isEmailVerified = "email_verified"
        case phoneNumber = "phone_number"
    }
    
    public let issuer: IssuerClaim
    public let issuedAt: IssuedAtClaim
    public let expirationAt: ExpirationClaim
    public let userID: String
    
    public let email: String?
    public let picture: String?
    public let name: String?
    public let authTime: Date?
    public let isEmailVerified: Bool?
    public let phoneNumber: String?
    
    /// The audience that this ID token is intended for. It must be one of the OAuth 2.0 client IDs of your application.
    public let audience: AudienceClaim
    
    /// An identifier for the user, unique among all Firebase accounts and never reused.
    public let subject: SubjectClaim
    
    public func verify(using signer: JWTSigner) throws {
        guard self.issuer.value.contains("securetoken.google.com") else {
            throw JWTError.claimVerificationFailure(name: "iss", reason: "Claim wasn't issued by Google")
        }
        
        guard self.subject.value.count <= 255 else {
            throw JWTError.claimVerificationFailure(name: "sub", reason: "Subject claim beyond 255 ASCII characters long.")
        }
        
        try self.expirationAt.verifyNotExpired()
    }
}

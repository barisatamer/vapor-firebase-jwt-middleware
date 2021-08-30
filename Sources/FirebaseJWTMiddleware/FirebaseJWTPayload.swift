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
        case firebase = "firebase"
    }
    
    /// Issuer. It must be "https://securetoken.google.com/<projectId>", where <projectId> is the same project ID used for aud
    public let issuer: IssuerClaim
    
    /// Issued-at time. It must be in the past. The time is measured in seconds since the UNIX epoch.
    public let issuedAt: IssuedAtClaim
    
    /// Expiration time. It must be in the future. The time is measured in seconds since the UNIX epoch.
    public let expirationAt: ExpirationClaim
    
    /// The audience that this ID token is intended for. It must be your Firebase project ID, the unique identifier for your Firebase project, which can be found in the URL of that project's console.
    public let audience: AudienceClaim
    
    /// Subject. It must be a non-empty string and must be the uid of the user or device.
    public let subject: SubjectClaim
    
    /// Authentication time. It must be in the past. The time when the user authenticated.
    public let authTime: Date?
    
    public let userID: String
    public let email: String?
    public let picture: String?
    public let name: String?
    public let isEmailVerified: Bool?
    public let phoneNumber: String?
    public let firebase: Firebase?
    
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

public struct Firebase: Codable {
    public let identities: [String: [String]]
    public let sign_in_provider: String
}


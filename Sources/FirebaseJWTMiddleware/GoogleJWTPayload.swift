//
//  GoogleJWTPayload.swift
//  FirebaseJWTMiddleware
//
//  Created by Baris Atamer on 23.08.19.
//

import JWT

struct AccessTokenPayload: JWTPayload {
    var issuer: IssuerClaim
    var issuedAt: IssuedAtClaim
    var expirationAt: ExpirationClaim
    var email: String
    var userID: String
    
    enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case issuedAt = "iat"
        case expirationAt = "exp"
        case email = "email"
        case userID = "user_id"
    }
    
    init(
        issuer: String,
        issuedAt: Date = Date(),
        expirationAt: Date = Date().addingTimeInterval(JWTConfig.expirationTime),
        email: String = "",
        userID: String = ""
        ) {
        self.issuer = IssuerClaim(value: issuer)
        self.issuedAt = IssuedAtClaim(value: issuedAt)
        self.expirationAt = ExpirationClaim(value: expirationAt)
        self.email = email
        self.userID = userID
    }
    
    func verify(using signer: JWTSigner) throws {
        guard self.issuer.value == "https://securetoken.google.com/phrase-book-vapor" else {
            throw JWTError.verificationFailed
        }
        
        try self.expirationAt.verifyNotExpired()
    }
}

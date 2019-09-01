//
//  TokenVerifier.swift
//  Async
//
//  Created by Baris Atamer on 23.08.19.
//

import JWT
import Crypto

public class TokenVerifier {
    
    @discardableResult
    public class func verify(_ token: String) throws -> FirebaseJWTPayload {
        let token = token.removeBearer()
        do {
            let certificates: [GoogleCertificate]? = try GoogleCertificateFetcher.fetch()
            let jwtSigners: JWTSigners = JWTSigners()
            certificates?.forEach({ (googleCertificate) in
                if let rsaKey = try? RSAKey.public(certificate: googleCertificate.certificate.bytes) {
                    let signer = JWTSigner.rs256(key: rsaKey)
                    jwtSigners.use(signer, kid: googleCertificate.kid)
                }
            })
            let jwt = try JWT<FirebaseJWTPayload>(from: token, verifiedUsing: jwtSigners)
            return jwt.payload
        } catch {
            throw JWTError.verificationFailed
        }
    }
}

extension String {
    var bytes: [UInt8] {
        return .init(self.utf8)
    }
    
    func removeBearer() -> String {
        return self.replacingOccurrences(of: "Bearer ", with: "")
    }
}

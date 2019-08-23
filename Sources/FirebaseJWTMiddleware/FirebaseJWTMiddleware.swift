import Vapor
import JWT
import Crypto

open class FirebaseJWTMiddleware: Middleware {
    
    public init() {}
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        if let token = request.http.headers[.authorization].first {
            do {
                try TokenHelpers.verifyToken(token)
                return try next.respond(to: request)
            } catch let error as JWTError {
                throw Abort(.unauthorized, reason: error.reason)
            }
        } else {
            throw Abort(.unauthorized, reason: "No Access Token")
        }
    }
}

enum JWTConfig {
    static let header = JWTHeader(alg: "RS256", typ: "JWT")
    static let expirationTime: TimeInterval = 50
}

extension String {
    var bytes: [UInt8] {
        return .init(self.utf8)
    }
}

extension JWTError {
    static let payloadCreation = JWTError(identifier: "TokenHelpers.createPayload", reason: "User ID not found")
    static let createJWT = JWTError(identifier: "TokenHelpers.createJWT", reason: "Error getting token string")
    static let verificationFailed = JWTError(identifier: "TokenHelpers.verifyToken", reason: "JWT verification failed")
}

class TokenHelpers {
    
    class func verifyToken(_ token: String) throws {
        let token = token.replacingOccurrences(of: "Bearer ", with: "")
        do {
            let certificates: [GoogleCertificate]? = try GoogleCertificateFetcher.fetch()
            let jwtSigners: JWTSigners = JWTSigners()
            certificates?.forEach({ (googleCertificate) in
                if let rsaKey = try? RSAKey.public(certificate: googleCertificate.certificate.bytes) {
                    let signer = JWTSigner.rs256(key: rsaKey)
                    jwtSigners.use(signer, kid: googleCertificate.kid)
                }
            })
            let _ = try JWT<AccessTokenPayload>(from: token, verifiedUsing: jwtSigners)
        } catch {
            throw JWTError.verificationFailed
        }
    }
}

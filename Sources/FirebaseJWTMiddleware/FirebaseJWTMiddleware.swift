import Vapor
import JWT

open class FirebaseJWTMiddleware: Middleware {
    
    public init() {}
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        if let token = request.http.headers[.authorization].first {
            do {
                try TokenVerifier.verify(token)
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


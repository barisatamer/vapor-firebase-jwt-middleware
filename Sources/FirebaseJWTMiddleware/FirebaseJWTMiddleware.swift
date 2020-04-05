import Vapor
import JWT

open class FirebaseJWTMiddleware: Middleware {
    
    public init() {}
    
    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        request.firebaseJwt.verify().transform(to: next.respond(to: request))
    }
}

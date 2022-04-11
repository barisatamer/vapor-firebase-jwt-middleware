import Vapor
import JWT

open class FirebaseJWTMiddleware: Middleware {

    public init() { }

    public func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        request.firebaseJwt.verify().transform(to: next.respond(to: request))
    }
}

open class AsyncFirebaseJWTMiddleware: AsyncMiddleware {

    public init() { }

    public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        _ = try await request.firebaseJwt.asyncVerify()
        return try await next.respond(to: request)
    }
}

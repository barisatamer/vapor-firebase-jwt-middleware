import Vapor
import JWT

open class FirebaseJWTMiddleware: AsyncMiddleware {

    public init() { }

    public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        _ = try await request.firebaseJwt.verify()
        return try await next.respond(to: request)
    }
}

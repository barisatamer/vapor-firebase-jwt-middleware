//
//  JWT+Firebase.swift
//  FirebaseJWTMiddleware
//
//  Created by Baris Atamer on 05.04.20.
//

import Vapor

extension Request {
    
    public var firebaseJwt: FirebaseJWT {
        .init(request: self)
    }
    
    public struct FirebaseJWT {
        
        let request: Request
        
        public func verify(applicationIdentifier: String? = nil) async throws -> FirebaseJWTPayload {
            guard let token = self.request.headers.bearerAuthorization?.token else {
                self.request.logger.error("Request is missing JWT bearer header.")
                throw Abort(.unauthorized)
            }
            return try await self.verify(token, applicationIdentifier: applicationIdentifier)
        }
        
        public func verify(_ message: String, applicationIdentifier: String? = nil) async throws -> FirebaseJWTPayload {
            try await self.verify([UInt8](message.utf8), applicationIdentifier: applicationIdentifier)
        }
        
        public func verify<Message>(_ message: Message, applicationIdentifier: String? = nil) async throws -> FirebaseJWTPayload where Message: DataProtocol {
            
            let signers = try await request.application.firebaseJwt.signers(on: request)
            
            let token = try signers.verify(message, as: FirebaseJWTPayload.self)

            if let applicationIdentifier = applicationIdentifier ?? self.request.application.firebaseJwt.applicationIdentifier {
                try token.audience.verifyIntendedAudience(includes: applicationIdentifier)
            }
            return token
        }
    }
}

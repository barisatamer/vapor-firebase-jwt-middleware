//
//  Application+FirebaseJWT.swift
//  AsyncHTTPClient
//
//  Created by Baris Atamer on 05.04.20.
//

import Vapor
import JWT

extension Application {
    public var firebaseJwt: FirebaseJWT {
        .init(application: self)
    }
    
    public struct FirebaseJWT {
        let application: Application
        
        public func signers(on request: Request) -> EventLoopFuture<JWTSigners> {
            self.jwks.get(on: request).flatMapThrowing {
                let signers = JWTSigners()
                try signers.use(jwks: $0)
                return signers
            }
        }
        
        public var jwks: EndpointCache<JWKS> {
            self.storage.jwks
        }
        
        public var applicationIdentifier: String? {
            get {
                self.storage.applicationIdentifier
            }
            nonmutating set {
                self.storage.applicationIdentifier = newValue
            }
        }
        
        private struct Key: StorageKey, LockKey {
            typealias Value = Storage
        }

        private final class Storage {
            let jwks: EndpointCache<JWKS>
            var applicationIdentifier: String?
            var gSuiteDomainName: String?
            init() {
                self.jwks = .init(uri: "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com")
                self.applicationIdentifier = nil
                self.gSuiteDomainName = nil
            }
        }
        
        private var storage: Storage {
            if let existing = self.application.storage[Key.self] {
                return existing
            } else {
                let lock = self.application.locks.lock(for: Key.self)
                lock.lock()
                defer { lock.unlock() }
                if let existing = self.application.storage[Key.self] {
                    return existing
                }
                let new = Storage()
                self.application.storage[Key.self] = new
                return new
            }
        }
    }
}

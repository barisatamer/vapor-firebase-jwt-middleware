//
//  FirebaseJWTMiddlewareConfig.swift
//  Async
//
//  Created by Baris Atamer on 23.08.19.
//

import JWT

/// Config options for a `FirebaseJWTPayload`
public struct FirebaseJWTMiddlewareConfig {
    static var shared = FirebaseJWTMiddlewareConfig()
    public var issuer: String?
    
    private init() {}
    
    public static func configure(issuer: String) {
        shared.issuer = issuer
    }
}

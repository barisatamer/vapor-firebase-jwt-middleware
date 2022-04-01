// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseJWTMiddleware",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(name: "FirebaseJWTMiddleware", targets: ["FirebaseJWTMiddleware"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
    ],
    targets: [
//        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .target(name: "FirebaseJWTMiddleware", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "JWT", package: "jwt")
        ]),
        .testTarget(name: "FirebaseJWTMiddlewareTests", dependencies: [
            .target(name: "FirebaseJWTMiddleware"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
    ]
)

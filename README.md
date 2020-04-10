<p align="center">
<img src="https://user-images.githubusercontent.com/789635/63635465-3d0f8500-c663-11e9-9ef2-15caa3477606.png" alt="FirebaseJWTMiddleware">
<br>
<a href="http://vapor.codes">
<img src="https://img.shields.io/badge/Vapor-4-F6CBCA.svg" alt="Vapor Version">
</a>
<a href="https://swift.org">
<img src="http://img.shields.io/badge/swift-5.2-brightgreen.svg" alt="Swift 5.2">
</a>
<a href="LICENSE">
<img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
</a>
</p>

## Installation 📦

To include it in your package, add the following to your `Package.swift` file.

```swift
let package = Package(
    name: "Project",
    dependencies: [
        ...
        .package(name: "FirebaseJWTMiddleware", url: "https://github.com/barisatamer/vapor-firebase-jwt-middleware.git", from: "1.0.0"),
        ],
        targets: [
            .target(name: "App", dependencies: [
                .product(name: "FirebaseJWTMiddleware", package: "FirebaseJWTMiddleware"),
                ... 
             ])
        ]
    )
```

## Usage 🚀
1. **Configure Project ID**
```swift
app.firebaseJwt.applicationIdentifier = <YOUR_FIREBASE_PROJECT_ID>
```
2. **Import header files**

```swift
import FirebaseJWTMiddleware
```

3. **Adding Middleware to a Routing Group**
```swift
let group = router.grouped(FirebaseJWTMiddleware())
group.get("welcome") { req in
return "Hello, world!"
}
```

## References
- [Verifying Firebase ID Tokens](https://firebase.google.com/docs/auth/admin/verify-id-tokens?authuser=1)



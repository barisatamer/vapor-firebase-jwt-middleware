import XCTest
import XCTVapor

@testable import FirebaseJWTMiddleware

final class FirebaseJWTMiddlewareTests: XCTestCase {
        let token = """
eyJhbGciOiJSUzI1NiIsImtpZCI6IjgzYTczOGUyMWI5MWNlMjRmNDM0ODBmZTZmZWU0MjU4Yzg0ZGI0YzUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQmFyaXMgQXRhbWVyIiwicGljdHVyZSI6Imh0dHBzOi8vbGg0Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tMlV2NmpUaXFrV3MvQUFBQUFBQUFBQUkvQUFBQUFBQUFBSDQvNmNieHFSSk56czQvczk2LWMvcGhvdG8uanBnIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3BocmFzZS1ib29rLXZhcG9yIiwiYXVkIjoicGhyYXNlLWJvb2stdmFwb3IiLCJhdXRoX3RpbWUiOjE1ODQzMjMxNTIsInVzZXJfaWQiOiJIaDZoYXhLRjNWTk1YRXdUaU12b0JZQ1NkN0IyIiwic3ViIjoiSGg2aGF4S0YzVk5NWEV3VGlNdm9CWUNTZDdCMiIsImlhdCI6MTU4NjEwMjQwMywiZXhwIjoxNTg2MTA2MDAzLCJlbWFpbCI6ImJyc2F0YW1lckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODcwMzM5MDExNTA3MTI2OTkxNSJdLCJlbWFpbCI6WyJicnNhdGFtZXJAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.I4NqedoNtJurciGNvvd2OnycXEdaem5Prwz0QtYlGgGTmRcsP0PEJjL6KHCayJyvH4DG_hGFRSmklKXI-_amVUy1Xv2-G0ooFKcxJAzTkfjDfJRwlYdaQGutConoUWcbBjQHPkGoHntvElFGm64PKH28iXr6uILDzfEJgHMoGkIGb-A89LCC4th4SZxNXg21Ms9YVsR06I66p7gBwx7CrWxlEB-xdHmVFJnQ9kXLf4OceuvmkRg_KXqWTaF9KXdCa9Nzr3DE6jNFuhT7ZhrU9rwDn6ZUGm8MTYAmScFiEnqC4PoQcrfgfxpkeB3a9IPM4CWGMxaBAM5fHwJ0HvtUfQ
"""
    static let applicationIdentifier: String = "phrase-book-vapor"

    func testFirebase() throws {
        // creates a new application for testing
        let app = Application(.testing)
        defer { app.shutdown() }
        
        app.firebaseJwt.applicationIdentifier = FirebaseJWTMiddlewareTests.applicationIdentifier
        
        app.get("test") { req in
            req.firebaseJwt.verify().map {
                $0.email ?? "none"
            }
        }
        
        var headers = HTTPHeaders()
        headers.bearerAuthorization = .init(token: token)
        
        try app.test(.GET, "test", headers: headers) { res in
            print(res.body.string)
            XCTAssert(res.body.string == "brsatamer@gmail.com")
        }
    }
    
    static var allTests = [
        ("testFirebase", testFirebase),
    ]
}

import XCTest
@testable import FirebaseJWTMiddleware

final class FirebaseJWTMiddlewareTests: XCTestCase {
    func testExample() {
        let token = """
eyJhbGciOiJSUzI1NiIsImtpZCI6IjI2OGNhNTBjZTY0YjQxYWIzNGZhMDM1NzIwMmQ5ZTk0ZTcyYmQ2ZWMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQmFyaXMgQXRhbWVyIiwicGljdHVyZSI6Imh0dHBzOi8vbGg0Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tMlV2NmpUaXFrV3MvQUFBQUFBQUFBQUkvQUFBQUFBQUFBSDQvNmNieHFSSk56czQvczk2LWMvcGhvdG8uanBnIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3BocmFzZS1ib29rLXZhcG9yIiwiYXVkIjoicGhyYXNlLWJvb2stdmFwb3IiLCJhdXRoX3RpbWUiOjE1NjYwMzYzNjAsInVzZXJfaWQiOiJIaDZoYXhLRjNWTk1YRXdUaU12b0JZQ1NkN0IyIiwic3ViIjoiSGg2aGF4S0YzVk5NWEV3VGlNdm9CWUNTZDdCMiIsImlhdCI6MTU2NjU5MDk3NiwiZXhwIjoxNTY2NTk0NTc2LCJlbWFpbCI6ImJyc2F0YW1lckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODcwMzM5MDExNTA3MTI2OTkxNSJdLCJlbWFpbCI6WyJicnNhdGFtZXJAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.Lfs8Hd7gh6D6q_9XAwaQDzZ-GykyB8YACudPmrkOH46HBFAdNMDgv5Z2AEbfahp8ZbMxZZVJQMjYYGomhbn7UwNqoXt3eKxazWB1JK1PQTzV9n-dVeUnTNNskJq7k7OXfWSWot0-KqwIhY248W8J4ftFChEQdWiJcljCr2i2yPDlETtvL_Dd9R65qPihfRodu4oMEmmHXEx_IeGfBQ_qiuKGdDYk-DKf3U5MleQae3w5NKHqX5JpruOtGLRNGhry6dDMEttMAkx9lZUj8cwfHTUNr05TONROpMhvWNxFGAFOb6zAcMPNPWS6TSURiBIa6k9u2WtXuNoS1LoHCsfa0Q
"""
        
        do {
            try TokenVerifier.verify(token)
        } catch {
            print(error)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

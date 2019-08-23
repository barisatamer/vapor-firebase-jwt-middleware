//
//  GoogleCertificate.swift
//  FirebaseJWTMiddleware
//
//  Created by Baris Atamer on 23.08.19.
//

import Foundation

struct GoogleCertificate {
    let kid: String
    let certificate: String
}

class GoogleCertificateFetcher {
    
    struct Constants {
        static let url = "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"
    }
    
    class func fetch() throws -> [GoogleCertificate]? {
        let response = try String(
            contentsOf: URL(string: Constants.url)!,
            encoding: .utf8
        )
        let data = Data(response.utf8)
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
            let googleCertificates = json.compactMap { (key: String, value: String) -> GoogleCertificate? in
                GoogleCertificate(kid: key, certificate: value)
            }
            return googleCertificates
        }
        return nil
    }
}

//
//  JWTState.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

struct JWTState: Codable {
    
    var jwt: String
    var expires: Date
    
    var isValid: Bool {
        return Date() < expires && jwt.isEmpty == false
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case jwt = "token"
        case expires = "expiration"
    }
    
    // MARK: - URL
    
    internal static let urlString = "\(Trefle.baseAPIURL)/auth/claim"
    internal static let url = URL(string: Self.urlString)
    internal static var urlRequest: URLRequest? {
        
        guard var urlComponents = URLComponents(string: Self.urlString) else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "token", value: Trefle.shared.accessToken),
            URLQueryItem(name: "origin", value: Trefle.shared.uri)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        return urlRequest
    }
    
}

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
    
}

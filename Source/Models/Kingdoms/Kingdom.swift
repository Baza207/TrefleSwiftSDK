//
//  Kingdom.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Kingdom: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let slug: String
    public let name: String
    public let subkingdoms: [SubkingdomRef]
    
    public var description: String {
        "Kingdom(identifier: \(identifier), slug: \(slug), name: \(name))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case name
        case subkingdoms
    }
    
}

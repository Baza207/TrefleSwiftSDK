//
//  Division.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Division: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let subkingdom: Subkingdom
    public let links: Links
    
    public var description: String {
        "Division(identifier: \(identifier), name: \(name), slug: \(slug), subkingdom: \(subkingdom))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case slug
        case subkingdom
        case links
    }
    
}

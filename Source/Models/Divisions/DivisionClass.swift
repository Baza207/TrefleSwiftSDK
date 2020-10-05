//
//  DivisionClass.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DivisionClass: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let division: Division?
    public let links: Links
    
    public var description: String {
        "DivisionClass(identifier: \(identifier), name: \(name), slug: \(slug))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case slug
        case division
        case links
    }
    
}

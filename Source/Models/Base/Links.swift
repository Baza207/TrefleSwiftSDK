//
//  Links.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-08-14.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Links: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let current: String
    public let first: String?
    public let last: String?
    public let previous: String?
    public let next: String?
    
    public let kingdom: String?
    public let subkingdom: String?
    public let division: String?
    public let divisionClass: String?
    public let divisionOrder: String?
    public let family: String?
    public let genus: String?
    public let plant: String?
    public let species: String?
    
    public var description: String {
        "Links(current: \(current))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case current = "self"
        case first
        case last
        case previous = "prev"
        case next
        
        case kingdom
        case subkingdom
        case division
        case divisionClass = "division_class"
        case divisionOrder = "division_order"
        case family
        case genus
        case plant
        case species
    }
    
}

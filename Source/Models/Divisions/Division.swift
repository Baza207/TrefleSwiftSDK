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
    public let slug: String
    public let name: String
    public let kingdom: Kingdom
    public let subkingdom: SubkingdomRef
    public let divisionClasses: [DivisionClassRef]
    
    public var description: String {
        "Division(identifier: \(identifier), slug: \(slug), name: \(name))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case name
        case kingdom
        case subkingdom
        case divisionClasses = "division_classes"
    }
    
}

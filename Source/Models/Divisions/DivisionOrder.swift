//
//  DivisionOrder.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DivisionOrder: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let slug: String
    public let name: String
    public let kingdom: Kingdom
    public let subkingdom: SubkingdomRef
    public let division: DivisionRef
    public let divisionClass: DivisionClassRef
    public let families: [FamilyRef]
    
    public var description: String {
        "DivisionOrder(identifier: \(identifier), slug: \(slug), name: \(name))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case name
        case kingdom
        case subkingdom
        case division
        case divisionClass = "division_class"
        case families
    }
    
}

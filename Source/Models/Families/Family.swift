//
//  Family.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Family: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let commonName: String?
    public let slug: String
    public let divisionOrder: DivisionOrder
    public let links: Links
    
    public var description: String {
        "Family(identifier: \(identifier), name: \(name), slug: \(slug), divisionOrder: \(divisionOrder))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case commonName = "common_name"
        case slug
        case divisionOrder = "division_order"
        case links
    }
    
}

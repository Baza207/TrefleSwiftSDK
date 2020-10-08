//
//  DivisionRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DivisionRef: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let subkingdom: Subkingdom
    public let links: Links
    
    public var description: String {
        "DivisionRef(identifier: \(identifier), name: \(name), slug: \(slug), subkingdom: \(subkingdom))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, slug: String, subkingdom: Subkingdom? = nil) {
        self.identifier = identifier
        self.name = name
        self.slug = slug
        self.subkingdom = subkingdom ?? Subkingdom.blank
        self.links = Links(current: "\(DivisionsManager.apiURL)/\(identifier)")
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "", slug: "")
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

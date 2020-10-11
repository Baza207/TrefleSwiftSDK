//
//  Subkingdom.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Subkingdom: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let kingdom: Kingdom
    public let links: Links
    
    public var description: String {
        "Subkingdom(identifier: \(identifier), name: \(name), slug: \(slug), kingdom: \(kingdom))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, slug: String, kingdom: Kingdom? = nil) {
        self.identifier = identifier
        self.name = name
        self.slug = slug
        self.kingdom = kingdom ?? Kingdom.blank
        self.links = Links(current: "\(SubkingdomsManager.apiURL)/\(identifier)")
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "", slug: "")
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case slug
        case kingdom
        case links
    }
    
}

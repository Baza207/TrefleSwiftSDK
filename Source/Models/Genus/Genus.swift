//
//  Genus.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Genus: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let family: Family
    public let links: Links
    
    public var description: String {
        "Genus(identifier: \(identifier), name: \(name), slug: \(slug), family: \(family))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, commonName: String? = nil, slug: String, family: Family? = nil) {
        self.identifier = identifier
        self.name = name
        self.slug = slug
        self.family = family ?? Family.blank
        self.links = Links(current: "\(GenusManager.apiURL)/\(identifier)")
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "", slug: "")
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case slug
        case family
        case links
    }
    
}

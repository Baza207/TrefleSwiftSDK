//
//  Zone.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Zone: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String
    public let tdwgCode: String
    public let tdwgLevel: Int
    public let speciesCount: Int
    public let links: Links
    private let parents: [Zone]?
    private var parent: Zone? { parents?.first }
    public let children: [Zone]?
    
    public var description: String {
        "Zone(identifier: \(identifier), name: \(name), tdwgCode: \(tdwgCode), tdwgLevel: \(tdwgLevel), speciesCount: \(speciesCount), links: \(links))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case slug
        case tdwgCode = "tdwg_code"
        case tdwgLevel = "tdwg_level"
        case speciesCount = "species_count"
        case links
        case parent
        case children
    }
    
    // MARK: - Init
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(Int.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        tdwgCode = try container.decode(String.self, forKey: .tdwgCode)
        tdwgLevel = try container.decode(Int.self, forKey: .tdwgLevel)
        speciesCount = try container.decode(Int.self, forKey: .speciesCount)
        links = try container.decode(Links.self, forKey: .links)
        if let parent = try container.decodeIfPresent(Zone.self, forKey: .parent) {
            parents = [parent]
        } else {
            parents = []
        }
        children = try container.decodeIfPresent([Zone].self, forKey: .children)
    }
    
}

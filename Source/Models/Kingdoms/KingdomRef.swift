//
//  Kingdom.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct KingdomRef: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let slug: String?
    public let links: Links
    
    public var description: String {
        "KingdomRef(identifier: \(identifier), name: \(name))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, slug: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.slug = slug
        self.links = Links(current: "\(KingdomsManager.apiURL)/\(identifier)")
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "")
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case name
        case links
    }
    
}

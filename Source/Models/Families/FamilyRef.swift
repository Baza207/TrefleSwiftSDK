//
//  FamilyRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct FamilyRef: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let commonName: String?
    public let slug: String
    public let divisionOrder: DivisionOrder?
    public let links: Links
    
    public var description: String {
        "FamilyRef(identifier: \(identifier), name: \(name), slug: \(slug))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, commonName: String? = nil, slug: String, divisionOrder: DivisionOrder? = nil) {
        self.identifier = identifier
        self.name = name
        self.commonName = commonName
        self.slug = slug
        self.divisionOrder = divisionOrder
        self.links = Links(current: "\(FamiliesManager.apiURL)/\(identifier)")
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "", slug: "")
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

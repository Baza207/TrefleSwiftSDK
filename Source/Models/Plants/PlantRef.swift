//
//  PlantRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct PlantRef: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let commonName: String?
    public let slug: String
    public let scientificName: String
    public let year: Int?
    public let bibliography: String?
    public let author: String?
    public let status: Status
    public let rank: Rank
    public let familyCommonName: String?
    public let familyName: String
    public let genusId: Int
    public let genusName: String
    public let imageURL: String?
    public let links: Links
    public let synonyms: [String]
    
    public var description: String {
        "PlantRef(identifier: \(identifier), slug: \(slug), scientificName: \(scientificName), familyName: \(familyName), genusName: \(genusName))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case commonName = "common_name"
        case slug
        case scientificName = "scientific_name"
        case year
        case bibliography
        case author
        case status
        case rank
        case familyCommonName = "family_common_name"
        case genusId = "genus_id"
        case imageURL = "image_url"
        case synonyms
        case genusName = "genus"
        case familyName = "family"
        case links
    }
    
}

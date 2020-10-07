//
//  Species.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Species: Decodable, CustomStringConvertible {
    
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
    public let duration: Duration?
    public let ediblePart: [EdiblePart]?
    public let edible: Bool?
    public let vegetable: Bool?
    public let observations: String?
    public let images: ImageCollection
    public let commonNames: [String: [String]]
    public let distributions: Distribution
    public let flower: Flower
    public let foliage: Foliage
    public let fruitOrSeed: FruitOrSeed
    public let specifications: Specification
    public let growth: Growth
    public let synonyms: [Synonym]
    public let sources: [Source]
    
    public var description: String {
        "Species(identifier: \(identifier), slug: \(slug), scientificName: \(scientificName), familyName: \(familyName), genusName: \(genusName))"
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
        case familyName = "family"
        case genusId = "genus_id"
        case genusName = "genus"
        case imageURL = "image_url"
        case links
        case duration
        case ediblePart = "edible_part"
        case edible
        case vegetable
        case observations
        case images
        case commonNames = "common_names"
        case distributions
        case flower
        case foliage
        case fruitOrSeed = "fruit_or_seed"
        case specifications
        case growth
        case synonyms
        case sources
    }
    
}

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
    public let familyName: String?
    public let genusId: Int
    public let genusName: String
    private let imageURLString: String?
    public var imageURL: URL? {
        guard let imageURLString = self.imageURLString else { return nil }
        let urlString: String
        if Trefle.shared.config.forceHttpsImageUrls == true {
            urlString = imageURLString.forceHttps()
        } else {
            urlString = imageURLString
        }
        return URL(string: urlString)
    }
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
        "Species(identifier: \(identifier), slug: \(slug), scientificName: \(scientificName), familyName: \(familyName ?? "-"), genusName: \(genusName))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, commonName: String? = nil, slug: String, scientificName: String, year: Int? = nil, bibliography: String? = nil, author: String? = nil, status: Status, rank: Rank, familyCommonName: String? = nil, familyName: String, genusId: Int, genusName: String, imageURL: String? = nil, duration: Duration? = nil, ediblePart: [EdiblePart]? = nil, edible: Bool? = nil, vegetable: Bool? = nil, observations: String? = nil, images: ImageCollection, commonNames: [String: [String]], distributions: Distribution, flower: Flower, foliage: Foliage, fruitOrSeed: FruitOrSeed, specifications: Specification, growth: Growth, synonyms: [Synonym], sources: [Source]) {
        self.identifier = identifier
        self.commonName = commonName
        self.slug = slug
        self.scientificName = scientificName
        self.year = year
        self.bibliography = bibliography
        self.author = author
        self.status = status
        self.rank = rank
        self.familyCommonName = familyCommonName
        self.familyName = familyName
        self.genusId = genusId
        self.genusName = genusName
        self.imageURLString = imageURL
        self.links = Links(current: "\(SpeciesManager.apiURL)/\(identifier)")
        self.duration = duration
        self.ediblePart = ediblePart
        self.edible = edible
        self.vegetable = vegetable
        self.observations = observations
        self.images = images
        self.commonNames = commonNames
        self.distributions = distributions
        self.flower = flower
        self.foliage = foliage
        self.fruitOrSeed = fruitOrSeed
        self.specifications = specifications
        self.growth = growth
        self.synonyms = synonyms
        self.sources = sources
    }
    
    internal static var blank: Self {
        Self(identifier: -1, slug: "", scientificName: "", status: .other(""), rank: .other(""), familyName: "", genusId: -1, genusName: "", images: ImageCollection.blank, commonNames: [:], distributions: Distribution.blank, flower: Flower.blank, foliage: Foliage.blank, fruitOrSeed: FruitOrSeed.blank, specifications: Specification.blank, growth: Growth.blank, synonyms: [], sources: [])
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
        case imageURLString = "image_url"
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

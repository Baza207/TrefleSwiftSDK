//
//  SpeciesRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-02.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct SpeciesRef: Decodable, CustomStringConvertible {
    
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
    public let synonyms: [String]
    
    public var description: String {
        "SpeciesRef(identifier: \(identifier), slug: \(slug), scientificName: \(scientificName), familyName: \(familyName ?? "-"), genusName: \(genusName))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, commonName: String? = nil, slug: String, scientificName: String, year: Int? = nil, bibliography: String? = nil, author: String? = nil, status: Status, rank: Rank, familyCommonName: String? = nil, familyName: String, genusId: Int, genusName: String, imageURL: String? = nil, synonyms: [String]) {
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
        self.synonyms = synonyms
    }
    
    internal static var blank: Self {
        Self(identifier: -1, slug: "", scientificName: "", status: .other(""), rank: .other(""), familyName: "", genusId: -1, genusName: "", synonyms: [])
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
        case synonyms
    }
    
}

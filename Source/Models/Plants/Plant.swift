//
//  Plant.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Plant: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let commonName: String?
    public let slug: String
    public let scientificName: String
    public let year: Int?
    public let bibliography: String?
    public let author: String?
    public let familyCommonName: String?
    public let genusId: Int
    public let mainSpeciesId: Int?
    public let vegetable: Bool?
    public let observations: String?
    public let mainSpecies: Species
    public let sources: [Source]
    public let links: Links
    
    public var description: String {
        "Plant(identifier: \(identifier), commonName: \(commonName ?? "-"), slug: \(slug), scientificName: \(scientificName), familyCommonName: \(familyCommonName ?? "-"))"
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
        case familyCommonName = "family_common_name"
        case genusId = "genus_id"
        case mainSpeciesId = "main_species_id"
        case vegetable
        case observations
        case mainSpecies = "main_species"
        case sources
        case links
    }
    
}

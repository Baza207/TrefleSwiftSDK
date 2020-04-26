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
    public let slug: String
    public let scientificName: String
    public let commonName: String?
    public let familyCommonName: String?
    public let duration: String?
    public let nativeStatus: String?
    public let isMainSpecies: Bool
    public let mainSpeciesId: Int?
    public let year: String?
    public let author: String?
    public let bibliography: String?
    public let type: String
    public let synonym: Bool
    public let status: String
    public let completeData: Bool
    
    public var description: String {
        "Species(identifier: \(identifier), scientificName: \(scientificName), commonName: \(commonName ?? "-"), familyCommonName: \(familyCommonName ?? "-"))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case scientificName = "scientific_name"
        case commonName = "common_name"
        case familyCommonName = "family_common_name"
        case duration
        case nativeStatus = "native_status"
        case isMainSpecies = "is_main_species"
        case mainSpeciesId = "main_species_id"
        case year
        case author
        case bibliography
        case type
        case synonym
        case status
        case completeData = "complete_data"
    }
    
}

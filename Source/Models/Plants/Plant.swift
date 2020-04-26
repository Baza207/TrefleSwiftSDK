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
    public let scientificName: String
    public let commonName: String?
    public let familyCommonName: String?
    public let duration: String?
    public let nativeStatus: String?
    public let images: [ImageRef]
    public let mainSpecies: Species
    public let cultivars: [Species]
    public let forms: [Species]
    public let hybrids: [Species]
    public let subSpecies: [Species]
    public let varieties: [Species]
    public let division: DivisionRef
    public let divisionClass: DivisionClassRef
    public let divisionOrder: DivisionOrderRef
    public let family: FamilyRef
    public let genus: GenusRef
    
    public var description: String {
        "Plant(identifier: \(identifier), scientificName: \(scientificName), commonName: \(commonName ?? "-"), familyCommonName: \(familyCommonName ?? "-"))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case scientificName = "scientific_name"
        case commonName = "common_name"
        case familyCommonName = "family_common_name"
        case duration
        case nativeStatus = "native_status"
        case images
        case mainSpecies = "main_species"
        case cultivars
        case forms
        case hybrids
        case subSpecies = "sub_species"
        case varieties
        case division
        case divisionClass = "class"
        case divisionOrder = "order"
        case family
        case genus
    }
    
}

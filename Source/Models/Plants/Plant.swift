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
    }
    
}

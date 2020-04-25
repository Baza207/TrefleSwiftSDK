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
    public let slug: String
    public let scientificName: String
    public let commonName: String?
    public let link: String
    public let completeData: Bool
    
    public var description: String {
        "PlantRef(identifier: \(identifier), slug: \(slug), scientificName: \(scientificName), commonName: \(commonName ?? "-"), link: \(link), completeData: \(completeData))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case scientificName = "scientific_name"
        case commonName = "common_name"
        case link
        case completeData = "complete_data"
    }
    
}

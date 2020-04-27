//
//  Source.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Source: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let speciesId: Int
    public let name: String
    public let sourceURL: String
    public let lastUpdate: String // FIXME: Parse date
    
    public var description: String {
        "Source(speciesId: \(speciesId), name: \(name), sourceURL: \(sourceURL), lastUpdate: \(lastUpdate))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case speciesId = "species_id"
        case name
        case sourceURL = "source_url"
        case lastUpdate = "last_update"
    }
    
}

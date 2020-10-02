//
//  FruitOrSeed.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct FruitOrSeed: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let conspicuous: Bool?
    public let color: [String]? // TODO: Enum "white" "red" "brown" "orange" "yellow" "lime" "green" "cyan" "blue" "purple" "magenta" "grey" "black"
    public let shape: String?
    public let seedPersistence: Bool?
    
    public var description: String {
        "FruitOrSeed(color: \(color ?? []), shape: \(shape ?? "-"))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case conspicuous
        case color
        case shape
        case seedPersistence = "seed_persistence"
    }
    
}

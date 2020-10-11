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
    public let color: [Color]?
    public let shape: String?
    public let seedPersistence: Bool?
    
    public var description: String {
        "FruitOrSeed(color: \(color ?? []), shape: \(shape ?? "-"))"
    }
    
    // MARK: - Init
    
    public init(conspicuous: Bool? = nil, color: [Color]? = nil, shape: String? = nil, seedPersistence: Bool? = nil) {
        self.conspicuous = conspicuous
        self.color = color
        self.shape = shape
        self.seedPersistence = seedPersistence
    }
    
    internal static var blank: Self {
        Self()
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case conspicuous
        case color
        case shape
        case seedPersistence = "seed_persistence"
    }
    
}

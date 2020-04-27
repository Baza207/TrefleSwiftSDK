//
//  Seed.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Seed: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let vegetativeSpreadRate: String?
    public let smallGrain: String?
    public let seedsPerPound: Float?
    public let seedlingVigor: String?
    public let seedSpreadRate: String?
    public let commercialAvailability: String?
    public let bloomPeriod: String?
    
    public var description: String {
        "Seed()"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case vegetativeSpreadRate = "vegetative_spread_rate"
        case smallGrain = "small_grain"
        case seedsPerPound = "seeds_per_pound"
        case seedlingVigor = "seedling_vigor"
        case seedSpreadRate = "seed_spread_rate"
        case commercialAvailability = "commercial_availability"
        case bloomPeriod = "bloom_period"
    }
    
}

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
    
    private let seedPersistenceOptional: Bool?
    public var seedPersistence: Bool { seedPersistenceOptional ?? false }
    public let seedPeriodEnd: String?
    public let seedPeriodBegin: String?
    public let seedAbundance: String?
    public let conspicuousOptional: Bool?
    public var conspicuous: Bool { conspicuousOptional ?? false }
    public let color: String?
    
    public var description: String {
        "FruitOrSeed(color: \(seedPersistence), seedPeriodEnd: \(seedPeriodEnd ?? "-"), seedPeriodBegin: \(seedPeriodBegin ?? "-"), seedAbundance: \(seedAbundance ?? "-"), conspicuous: \(conspicuous), color: \(color ?? "-"))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case seedPersistenceOptional = "seed_persistence"
        case seedPeriodEnd = "seed_period_end"
        case seedPeriodBegin = "seed_period_begin"
        case seedAbundance = "seed_abundance"
        case conspicuousOptional
        case color
    }
    
}

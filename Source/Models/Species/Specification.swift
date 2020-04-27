//
//  Specification.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Specification: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let toxicity: String?
    public let shapeAndOrientation: String?
    public let regrowthRate: String?
    public let nitrogenFixation: String?
    public let maxHeightAtBaseAge: LengthMeasure?
    public let matureHeight: LengthMeasure?
    public let lowGrowingGrass: String?
    public let lifespan: String?
    public let leafRetention: String?
    public let knownAllelopath: String?
    public let growthRate: String?
    public let growthPeriod: String?
    public let growthHabit: String?
    public let growthForm: String?
    public let fireResistance: String?
    public let fallConspicuous: Bool
    public let coppicePotential: Bool
    public let cnRatio: String?
    public let bloat: String?
    
    public var description: String {
        "Specification()"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case toxicity
        case shapeAndOrientation = "shape_and_orientation"
        case regrowthRate = "regrowth_rate"
        case nitrogenFixation = "nitrogen_fixation"
        case maxHeightAtBaseAge = "max_height_at_base_age"
        case matureHeight = "mature_height"
        case lowGrowingGrass = "low_growing_grass"
        case lifespan
        case leafRetention = "leaf_retention"
        case knownAllelopath = "known_allelopath"
        case growthRate = "growth_rate"
        case growthPeriod = "growth_period"
        case growthHabit = "growth_habit"
        case growthForm = "growth_form"
        case fireResistance = "fire_resistance"
        case fallConspicuous = "fall_conspicuous"
        case coppicePotential = "coppice_potential"
        case cnRatio = "c_n_ratio"
        case bloat
    }
    
}

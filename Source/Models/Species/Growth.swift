//
//  Growth.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Growth: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let temperatureMinimum: TemperatureMeasure?
    public let shadeTolerance: String?
    public let salinityTolerance: String?
    public let rootDepthMinimum: LengthMeasure
    public let resproutAbility: String?
    public let precipitationMinimum: LengthMeasure
    public let precipitationMaximum: LengthMeasure
    public let plantingDensityMinimum: AreaMeasure
    public let plantingDensityMaximum: AreaMeasure
    public let phMinimum: Float?
    public let phMaximum: Float?
    public let moistureUse: String?
    public let hedgeTolerance: String?
    public let frostFreeDaysMinimum: Float?
    public let fireTolerance: String?
    public let fertilityRequirement: String?
    public let droughtTolerance: String?
    private let coldStratificationRequiredOptional: Bool?
    public var coldStratificationRequired: Bool { coldStratificationRequiredOptional ?? false }
    public let caco3Tolerance: String?
    public let anaerobicTolerance: String?
    
    public var description: String {
        "Growth()"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case temperatureMinimum = "temperature_minimum"
        case shadeTolerance = "shade_tolerance"
        case salinityTolerance = "salinity_tolerance"
        case rootDepthMinimum = "root_depth_minimum"
        case resproutAbility = "resprout_ability"
        case precipitationMinimum = "precipitation_minimum"
        case precipitationMaximum = "precipitation_maximum"
        case plantingDensityMinimum = "planting_density_minimum"
        case plantingDensityMaximum = "planting_density_maximum"
        case phMinimum = "ph_minimum"
        case phMaximum = "ph_maximum"
        case moistureUse = "moisture_use"
        case hedgeTolerance = "hedge_tolerance"
        case frostFreeDaysMinimum = "frost_free_days_minimum"
        case fireTolerance = "fire_tolerance"
        case fertilityRequirement = "fertility_requirement"
        case droughtTolerance = "drought_tolerance"
        case coldStratificationRequiredOptional = "cold_stratification_required"
        case caco3Tolerance = "caco_3_tolerance"
        case anaerobicTolerance = "anaerobic_tolerance"
    }
    
}

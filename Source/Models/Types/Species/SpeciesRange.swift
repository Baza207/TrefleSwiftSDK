//
//  SpeciesRange.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum SpeciesRange: Hashable {
    case atmosphericHumidity
    case frostFreeDaysMinimum
    case groundHumidity
    case imagesCount
    case light
    case averageHeightcm
    case maximumHeightcm
    case maximumPrecipitationmm
    case maximumTemperatureDegc
    case maximumTemperatureDegf
    case minimumPrecipitationmm
    case minimumRootDepthcm
    case minimumTemperatureDegc
    case minimumTemperatureDegf
    case phMaximum
    case phMinimum
    case plantingDaysToHarvest
    case plantingRowSpacingcm
    case plantingSpreadcm
    case soilNutriments
    case soilSalinity
    case soilTexture
    case synonymsCount
    case sourcesCount
    case toxicity
    case year
    case other(String)
    
    public init(rawValue: String) {
        switch rawValue {
        case "atmospheric_humidity":
            self = .atmosphericHumidity
        case "frost_free_days_minimum":
            self = .frostFreeDaysMinimum
        case "ground_humidity":
            self = .groundHumidity
        case "images_count":
            self = .imagesCount
        case "light":
            self = .light
        case "average_height_cm":
            self = .averageHeightcm
        case "maximum_height_cm":
            self = .maximumHeightcm
        case "maximum_precipitation_mm":
            self = .maximumPrecipitationmm
        case "maximum_temperature_deg_c":
            self = .maximumTemperatureDegc
        case "maximum_temperature_deg_f":
            self = .maximumTemperatureDegf
        case "minimum_precipitation_mm":
            self = .minimumPrecipitationmm
        case "minimum_root_depth_cm":
            self = .minimumRootDepthcm
        case "minimum_temperature_deg_c":
            self = .minimumTemperatureDegc
        case "minimum_temperature_deg_f":
            self = .minimumTemperatureDegf
        case "ph_maximum":
            self = .phMaximum
        case "ph_minimum":
            self = .phMinimum
        case "planting_days_to_harvest":
            self = .plantingDaysToHarvest
        case "planting_row_spacing_cm":
            self = .plantingRowSpacingcm
        case "planting_spread_cm":
            self = .plantingSpreadcm
        case "soil_nutriments":
            self = .soilNutriments
        case "soil_salinity":
            self = .soilSalinity
        case "soil_texture":
            self = .soilTexture
        case "synonyms_count":
            self = .synonymsCount
        case "sources_count":
            self = .sourcesCount
        case "toxicity":
            self = .toxicity
        case "year":
            self = .year
        default:
            self = .other(rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .atmosphericHumidity:
            return "atmospheric_humidity"
        case .frostFreeDaysMinimum:
            return "frost_free_days_minimum"
        case .groundHumidity:
            return "ground_humidity"
        case .imagesCount:
            return "images_count"
        case .light:
            return "light"
        case .averageHeightcm:
            return "average_height_cm"
        case .maximumHeightcm:
            return "maximum_height_cm"
        case .maximumPrecipitationmm:
            return "maximum_precipitation_mm"
        case .maximumTemperatureDegc:
            return "maximum_temperature_deg_c"
        case .maximumTemperatureDegf:
            return "maximum_temperature_deg_f"
        case .minimumPrecipitationmm:
            return "minimum_precipitation_mm"
        case .minimumRootDepthcm:
            return "minimum_root_depth_cm"
        case .minimumTemperatureDegc:
            return "minimum_temperature_deg_c"
        case .minimumTemperatureDegf:
            return "minimum_temperature_deg_f"
        case .phMaximum:
            return "ph_maximum"
        case .phMinimum:
            return "ph_minimum"
        case .plantingDaysToHarvest:
            return "planting_days_to_harvest"
        case .plantingRowSpacingcm:
            return "planting_row_spacing_cm"
        case .plantingSpreadcm:
            return "planting_spread_cm"
        case .soilNutriments:
            return "soil_nutriments"
        case .soilSalinity:
            return "soil_salinity"
        case .soilTexture:
            return "soil_texture"
        case .synonymsCount:
            return "synonyms_count"
        case .sourcesCount:
            return "sources_count"
        case .toxicity:
            return "toxicity"
        case .year:
            return "year"
        case .other(let rawValue):
            return rawValue
        }
    }
    
}

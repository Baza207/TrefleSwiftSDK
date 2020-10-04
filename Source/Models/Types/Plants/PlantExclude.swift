//
//  PlantExclude.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

// swiftlint:disable cyclomatic_complexity
public enum PlantExclude: Hashable {
    case imageURL
    case author
    case averageHeightcm
    case bibliography
    case commonName
    case ediblePart
    case familyCommonName
    case familyName
    case flowerColor
    case flowerConspicuous
    case foliageColor
    case foliageTexture
    case frostFreeDaysMinimum
    case fruitColor
    case fruitConspicuous
    case fruitSeedPersistence
    case groundHumidity
    case growthForm
    case growthHabit
    case growthRate
    case genusName
    case imagesCount
    case leafRetention
    case light
    case ligneousType
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
    case rank
    case scientificName
    case soilNutriments
    case soilSalinity
    case soilTexture
    case status
    case synonymsCount
    case sourcesCount
    case toxicity
    case vegetable
    case year
    case other(String)
    
    public init(rawValue: String) {
        switch rawValue {
        case "image_url":
            self = .imageURL
        case "author":
            self = .author
        case "average_height_cm":
            self = .averageHeightcm
        case "bibliography":
            self = .bibliography
        case "common_name":
            self = .commonName
        case "edible_part":
            self = .ediblePart
        case "family_common_name":
            self = .familyCommonName
        case "family_name":
            self = .familyName
        case "flower_color":
            self = .flowerColor
        case "flower_conspicuous":
            self = .flowerConspicuous
        case "foliage_color":
            self = .foliageColor
        case "foliage_texture":
            self = .foliageTexture
        case "frost_free_days_minimum":
            self = .frostFreeDaysMinimum
        case "fruit_color":
            self = .fruitColor
        case "fruit_conspicuous":
            self = .fruitConspicuous
        case "fruit_seed_persistence":
            self = .fruitSeedPersistence
        case "ground_humidity":
            self = .groundHumidity
        case "growth_form":
            self = .growthForm
        case "growth_habit":
            self = .growthHabit
        case "growth_rate":
            self = .growthRate
        case "genus_name":
            self = .genusName
        case "images_count":
            self = .imagesCount
        case "leaf_retention":
            self = .leafRetention
        case "light":
            self = .light
        case "ligneous_type":
            self = .ligneousType
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
        case "rank":
            self = .rank
        case "scientific_name":
            self = .scientificName
        case "soil_nutriments":
            self = .soilNutriments
        case "soil_salinity":
            self = .soilSalinity
        case "soil_texture":
            self = .soilTexture
        case "status":
            self = .status
        case "synonyms_count":
            self = .synonymsCount
        case "sources_count":
            self = .sourcesCount
        case "toxicity":
            self = .toxicity
        case "vegetable":
            self = .vegetable
        case "year":
            self = .year
        default:
            self = .other(rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .imageURL:
            return "image_url"
        case .author:
            return "author"
        case .averageHeightcm:
            return "average_height_cm"
        case .bibliography:
            return "bibliography"
        case .commonName:
            return "common_name"
        case .ediblePart:
            return "edible_part"
        case .familyCommonName:
            return "family_common_name"
        case .familyName:
            return "family_name"
        case .flowerColor:
            return "flower_color"
        case .flowerConspicuous:
            return "flower_conspicuous"
        case .foliageColor:
            return "foliage_color"
        case .foliageTexture:
            return "foliage_texture"
        case .frostFreeDaysMinimum:
            return "frost_free_days_minimum"
        case .fruitColor:
            return "fruit_color"
        case .fruitConspicuous:
            return "fruit_conspicuous"
        case .fruitSeedPersistence:
            return "fruit_seed_persistence"
        case .groundHumidity:
            return "ground_humidity"
        case .growthForm:
            return "growth_form"
        case .growthHabit:
            return "growth_habit"
        case .growthRate:
            return "growth_rate"
        case .genusName:
            return "genus_name"
        case .imagesCount:
            return "images_count"
        case .leafRetention:
            return "leaf_retention"
        case .light:
            return "light"
        case .ligneousType:
            return "ligneous_type"
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
        case .rank:
            return "rank"
        case .scientificName:
            return "scientific_name"
        case .soilNutriments:
            return "soil_nutriments"
        case .soilSalinity:
            return "soil_salinity"
        case .soilTexture:
            return "soil_texture"
        case .status:
            return "status"
        case .synonymsCount:
            return "synonyms_count"
        case .sourcesCount:
            return "sources_count"
        case .toxicity:
            return "toxicity"
        case .vegetable:
            return "vegetable"
        case .year:
            return "year"
        case .other(let rawValue):
            return rawValue
        }
    }
}
// swiftlint:enable cyclomatic_complexity

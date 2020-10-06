//
//  SpeciesFilter.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum SpeciesFilter: Hashable {
    case author
    case bloomMonths
    case commonName
    case duration
    case edible
    case familyCommonName
    case familyName
    case flowerConspicuous
    case foliageTexture
    case fruitConspicuous
    case fruitSeedPersistence
    case growthForm
    case growthHabit
    case growthRate
    case leafRetention
    case ligneousType
    case rank
    case scientificName
    case status
    case vegetable
    case growthMonths
    case fruitMonths
    case flowerColor
    case foliageColor
    case fruitColor
    case ediblePart
    case genusName
    case other(String)
    
    public init(rawValue: String) {
        switch rawValue {
        case "author":
            self = .author
        case "bloom_months":
            self = .bloomMonths
        case "common_name":
            self = .commonName
        case "duration":
            self = .duration
        case "edible":
            self = .edible
        case "family_common_name":
            self = .familyCommonName
        case "family_name":
            self = .familyName
        case "flower_conspicuous":
            self = .flowerConspicuous
        case "foliage_texture":
            self = .foliageTexture
        case "fruit_conspicuous":
            self = .fruitConspicuous
        case "fruit_seed_persistence":
            self = .fruitSeedPersistence
        case "growth_form":
            self = .growthForm
        case "growth_habit":
            self = .growthHabit
        case "growth_rate":
            self = .growthRate
        case "leaf_retention":
            self = .leafRetention
        case "ligneous_type":
            self = .ligneousType
        case "rank":
            self = .rank
        case "scientific_name":
            self = .scientificName
        case "status":
            self = .status
        case "vegetable":
            self = .vegetable
        case "growth_months":
            self = .growthMonths
        case "fruit_months":
            self = .fruitMonths
        case "flower_color":
            self = .flowerColor
        case "foliage_color":
            self = .foliageColor
        case "fruit_color":
            self = .fruitColor
        case "edible_part":
            self = .ediblePart
        case "genus_name":
            self = .genusName
        default:
            self = .other(rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .author:
            return "author"
        case .bloomMonths:
            return "bloom_months"
        case .commonName:
            return "common_name"
        case .duration:
            return "duration"
        case .edible:
            return "edible"
        case .familyCommonName:
            return "family_common_name"
        case .familyName:
            return "family_name"
        case .flowerConspicuous:
            return "flower_conspicuous"
        case .foliageTexture:
            return "foliage_texture"
        case .fruitConspicuous:
            return "fruit_conspicuous"
        case .fruitSeedPersistence:
            return "fruit_seed_persistence"
        case .growthForm:
            return "growth_form"
        case .growthHabit:
            return "growth_habit"
        case .growthRate:
            return "growth_rate"
        case .leafRetention:
            return "leaf_retention"
        case .ligneousType:
            return "ligneous_type"
        case .rank:
            return "rank"
        case .scientificName:
            return "scientific_name"
        case .status:
            return "status"
        case .vegetable:
            return "vegetable"
        case .growthMonths:
            return "growth_months"
        case .fruitMonths:
            return "fruit_months"
        case .flowerColor:
            return "flower_color"
        case .foliageColor:
            return "foliage_color"
        case .fruitColor:
            return "fruit_color"
        case .ediblePart:
            return "edible_part"
        case .genusName:
            return "genus_name"
        case .other(let rawValue):
            return rawValue
        }
    }
    
}

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
    
    public let daysToHarvest: Double?
    public let growthDescription: String?
    public let sowing: String?
    public let phMinimum: Double?
    public let phMaximum: Double?
    public let light: Int?
    public let atmosphericHumidity: Int?
    public let growthMonths: [Month]?
    public let bloomMonths: [Month]?
    public let fruitMonths: [Month]?
    public let rowSpacing: [String: Double?]
    public let spread: [String: Double?]
    public let minimumPrecipitation: [String: Double?]
    public let maximumPrecipitation: [String: Double?]
    public let minimumRootDepth: [String: Double?]
    public let minimumTemperature: [String: Double?]
    public let maximumTemperature: [String: Double?]
    public let soilNutriments: Int?
    public let soilSalinity: Int?
    public let soilTexture: Int?
    public let soilHumidity: Int?
    
    public var description: String {
        "Growth()"
    }
    
    // MARK: - Init
    
    public init(daysToHarvest: Double? = nil, growthDescription: String? = nil, sowing: String? = nil, phMinimum: Double? = nil, phMaximum: Double? = nil, light: Int? = nil, atmosphericHumidity: Int? = nil, growthMonths: [Month]? = nil, bloomMonths: [Month]? = nil, fruitMonths: [Month]? = nil, rowSpacing: [String: Double?], spread: [String: Double?], minimumPrecipitation: [String: Double?], maximumPrecipitation: [String: Double?], minimumRootDepth: [String: Double?], minimumTemperature: [String: Double?], maximumTemperature: [String: Double?], soilNutriments: Int? = nil, soilSalinity: Int? = nil, soilTexture: Int? = nil, soilHumidity: Int? = nil) {
        self.daysToHarvest = daysToHarvest
        self.growthDescription = growthDescription
        self.sowing = sowing
        self.phMinimum = phMinimum
        self.phMaximum = phMaximum
        self.light = light
        self.atmosphericHumidity = atmosphericHumidity
        self.growthMonths = growthMonths
        self.bloomMonths = bloomMonths
        self.fruitMonths = fruitMonths
        self.rowSpacing = rowSpacing
        self.spread = spread
        self.minimumPrecipitation = minimumPrecipitation
        self.maximumPrecipitation = maximumPrecipitation
        self.minimumRootDepth = minimumRootDepth
        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.soilNutriments = soilNutriments
        self.soilSalinity = soilSalinity
        self.soilTexture = soilTexture
        self.soilHumidity = soilHumidity
    }
    
    internal static var blank: Self {
        Self(rowSpacing: [:], spread: [:], minimumPrecipitation: [:], maximumPrecipitation: [:], minimumRootDepth: [:], minimumTemperature: [:], maximumTemperature: [:])
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case daysToHarvest = "days_to_harvest"
        case growthDescription = "description"
        case sowing
        case phMinimum = "ph_minimum"
        case phMaximum = "ph_maximum"
        case light
        case atmosphericHumidity = "atmospheric_humidity"
        case growthMonths = "growth_months"
        case bloomMonths = "bloom_months"
        case fruitMonths = "fruit_months"
        case rowSpacing = "row_spacing"
        case spread
        case minimumPrecipitation = "minimum_precipitation"
        case maximumPrecipitation = "maximum_precipitation"
        case minimumRootDepth = "minimum_root_depth"
        case minimumTemperature = "minimum_temperature"
        case maximumTemperature = "maximum_temperature"
        case soilNutriments = "soil_nutriments"
        case soilSalinity = "soil_salinity"
        case soilTexture = "soil_texture"
        case soilHumidity = "soil_humidity"
    }
    
}

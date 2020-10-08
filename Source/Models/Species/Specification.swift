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
    
    public let ligneousType: LigneousType?
    public let growthForm: String?
    public let growthHabit: String?
    public let growthRate: String?
    public let averageHeight: [String: Double?]
    public let maximumHeight: [String: Double?]
    public let nitrogenFixation: String?
    public let shapeAndOrientation: String?
    public let toxicity: Toxicity?
    
    public var description: String {
        "Specification(ligneousType: \(ligneousType?.rawValue ?? "-"), growthForm: \(growthForm ?? "-"), growthHabit: \(growthHabit ?? "-"), growthRate: \(growthRate ?? "-"), averageHeight: \(averageHeight ), maximumHeight: \(maximumHeight), nitrogenFixation: \(nitrogenFixation ?? "-"), shapeAndOrientation: \(shapeAndOrientation ?? "-"), toxicity: \(toxicity?.rawValue ?? "-"))"
    }
    
    // MARK: - Init
    
    public init(ligneousType: LigneousType? = nil, growthForm: String? = nil, growthHabit: String? = nil, growthRate: String? = nil, averageHeight: [String: Double?], maximumHeight: [String: Double?], nitrogenFixation: String? = nil, shapeAndOrientation: String? = nil, toxicity: Toxicity? = nil) {
        self.ligneousType = ligneousType
        self.growthForm = growthForm
        self.growthHabit = growthHabit
        self.growthRate = growthRate
        self.averageHeight = averageHeight
        self.maximumHeight = maximumHeight
        self.nitrogenFixation = nitrogenFixation
        self.shapeAndOrientation = shapeAndOrientation
        self.toxicity = toxicity
    }
    
    internal static var blank: Self {
        Self(averageHeight: [:], maximumHeight: [:])
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case ligneousType = "ligneous_type"
        case growthForm = "growth_form"
        case growthHabit = "growth_habit"
        case growthRate = "growth_rate"
        case averageHeight = "average_height"
        case maximumHeight = "maximum_height"
        case nitrogenFixation = "nitrogen_fixation"
        case shapeAndOrientation = "shape_and_orientation"
        case toxicity
    }
    
}

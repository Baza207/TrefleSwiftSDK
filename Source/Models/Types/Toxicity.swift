//
//  Toxicity.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Toxicity: Decodable {
    case none
    case low
    case medium
    case high
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "none":
            self = .none
        case "low":
            self = .low
        case "medium":
            self = .medium
        case "high":
            self = .high
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Toxicity(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .none:
            return "none"
        case .low:
            return "low"
        case .medium:
            return "medium"
        case .high:
            return "high"
        case .other(let rawValue):
            return rawValue
        }
    }
}

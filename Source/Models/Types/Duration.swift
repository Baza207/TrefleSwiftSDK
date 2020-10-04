//
//  Duration.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Duration: Decodable {
    case annual
    case biennial
    case perennial
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "annual":
            self = .annual
        case "biennial":
            self = .biennial
        case "perennial":
            self = .perennial
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Duration(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .annual:
            return "annual"
        case .biennial:
            return "biennial"
        case .perennial:
            return "perennial"
        case .other(let rawValue):
            return rawValue
        }
    }
}

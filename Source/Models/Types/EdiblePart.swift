//
//  EdiblePart.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum EdiblePart: Decodable {
    case roots
    case stem
    case leaves
    case flowers
    case fruits
    case seeds
    case tubers
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "roots":
            self = .roots
        case "stem":
            self = .stem
        case "leaves":
            self = .leaves
        case "flowers":
            self = .flowers
        case "fruits":
            self = .fruits
        case "seeds":
            self = .seeds
        case "tubers":
            self = .tubers
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = EdiblePart(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .roots:
            return "roots"
        case .stem:
            return "stem"
        case .leaves:
            return "leaves"
        case .flowers:
            return "flowers"
        case .fruits:
            return "fruits"
        case .seeds:
            return "seeds"
        case .tubers:
            return "tubers"
        case .other(let rawValue):
            return rawValue
        }
    }
}

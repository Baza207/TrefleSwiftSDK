//
//  Rank.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Rank: Decodable {
    case species
    case ssp
    case `var`
    case form
    case hybrid
    case subvar
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "species":
            self = .species
        case "ssp":
            self = .ssp
        case "var":
            self = .var
        case "form":
            self = .form
        case "hybrid":
            self = .hybrid
        case "subvar":
            self = .subvar
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Rank(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .species:
            return "species"
        case .ssp:
            return "ssp"
        case .var:
            return "var"
        case .form:
            return "form"
        case .hybrid:
            return "hybrid"
        case .subvar:
            return "subvar"
        case .other(let rawValue):
            return rawValue
        }
    }
}

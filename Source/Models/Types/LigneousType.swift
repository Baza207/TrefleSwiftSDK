//
//  LigneousType.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum LigneousType: Decodable {
    case liana
    case subshrub
    case shrub
    case tree
    case parasite
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "liana":
            self = .liana
        case "subshrub":
            self = .subshrub
        case "shrub":
            self = .shrub
        case "tree":
            self = .tree
        case "parasite":
            self = .parasite
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = LigneousType(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .liana:
            return "liana"
        case .subshrub:
            return "subshrub"
        case .shrub:
            return "shrub"
        case .tree:
            return "tree"
        case .parasite:
            return "parasite"
        case .other(let rawValue):
            return rawValue
        }
    }
}

//
//  Texture.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Texture: Decodable {
    case fine
    case medium
    case coarse
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "fine":
            self = .fine
        case "medium":
            self = .medium
        case "coarse":
            self = .coarse
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Texture(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .fine:
            return "fine"
        case .medium:
            return "medium"
        case .coarse:
            return "coarse"
        case .other(let rawValue):
            return rawValue
        }
    }
}

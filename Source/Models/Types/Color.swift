//
//  Color.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Color: Decodable {
    case white
    case red
    case brown
    case orange
    case yellow
    case lime
    case green
    case cyan
    case blue
    case purple
    case magenta
    case grey
    case black
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "white":
            self = .white
        case "red":
            self = .red
        case "brown":
            self = .brown
        case "orange":
            self = .orange
        case "yellow":
            self = .yellow
        case "lime":
            self = .lime
        case "green":
            self = .green
        case "cyan":
            self = .cyan
        case "blue":
            self = .blue
        case "purple":
            self = .purple
        case "magenta":
            self = .magenta
        case "grey":
            self = .grey
        case "black":
            self = .black
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Color(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .white:
            return "white"
        case .red:
            return "red"
        case .brown:
            return "brown"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .lime:
            return "lime"
        case .green:
            return "green"
        case .cyan:
            return "cyan"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        case .magenta:
            return "magenta"
        case .grey:
            return "grey"
        case .black:
            return "black"
        case .other(let rawValue):
            return rawValue
        }
    }
}

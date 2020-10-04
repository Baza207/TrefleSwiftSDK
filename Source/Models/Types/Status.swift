//
//  Status.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-03.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Status: Decodable {
    case accepted
    case unknown
    case other(String)
    
    // MARK: - Init
    
    public init(rawValue: String) {
        switch rawValue {
        case "accepted":
            self = .accepted
        case "unknown":
            self = .unknown
        default:
            self = .other(rawValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Status(rawValue: rawValue)
    }
    
    // MARK: - Helpers
    
    public var rawValue: String {
        switch self {
        case .accepted:
            return "accepted"
        case .unknown:
            return "unknown"
        case .other(let rawValue):
            return rawValue
        }
    }
}

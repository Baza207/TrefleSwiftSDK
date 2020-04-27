//
//  Flower.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Flower: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let color: String?
    private let conspicuousOptional: Bool?
    public var conspicuous: Bool { conspicuousOptional ?? false }
    
    public var description: String {
        "Flower(color: \(color ?? "-"), conspicuous: \(conspicuous))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case color
        case conspicuousOptional = "conspicuous"
    }
    
}

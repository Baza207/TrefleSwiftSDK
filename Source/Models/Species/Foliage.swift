//
//  Foliage.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Foliage: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let texture: String? // TODO: Enum "fine" "medium" "coarse"
    public let color: [String]? // TODO: Enum "white" "red" "brown" "orange" "yellow" "lime" "green" "cyan" "blue" "purple" "magenta" "grey" "black"
    public let leafRetention: Bool?
    
    public var description: String {
        "Foliage(texture: \(texture ?? "-"), color: \(color ?? []))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case texture
        case color
        case leafRetention = "leaf_retention"
    }
    
}

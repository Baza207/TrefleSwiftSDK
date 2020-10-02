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
    
    public let color: [String]? // TODO: Enum "white" "red" "brown" "orange" "yellow" "lime" "green" "cyan" "blue" "purple" "magenta" "grey" "black"
    public let conspicuous: Bool?
    
    public var description: String {
        "Flower(color: \(color ?? []))"
    }
    
}

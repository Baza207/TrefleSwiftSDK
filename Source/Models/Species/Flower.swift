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
    
    public let color: [Color]?
    public let conspicuous: Bool?
    
    public var description: String {
        "Flower(color: \(color ?? []))"
    }
    
    // MARK: - Init
    
    public init(color: [Color]? = nil, conspicuous: Bool? = nil) {
        self.color = color
        self.conspicuous = conspicuous
    }
    
    internal static var blank: Self {
        Self()
    }
    
}

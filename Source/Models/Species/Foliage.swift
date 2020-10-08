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
    
    public let texture: Texture?
    public let color: [Color]?
    public let leafRetention: Bool?
    
    public var description: String {
        "Foliage(texture: \(texture?.rawValue ?? "-"), color: \(color ?? []))"
    }
    
    // MARK: - Init
    
    public init(texture: Texture? = nil, color: [Color]? = nil, leafRetention: Bool? = nil) {
        self.texture = texture
        self.color = color
        self.leafRetention = leafRetention
    }
    
    internal static var blank: Self {
        Self()
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case texture
        case color
        case leafRetention = "leaf_retention"
    }
    
}

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
    
    public let texture: String?
    public let porosityWinter: String?
    public let porositySummer: String?
    public let color: String?
    
    public var description: String {
        "Foliage(texture: \(texture ?? "-"), porosityWinter: \(porosityWinter ?? "-"), porositySummer: \(porositySummer ?? "-"), color: \(color ?? "-"))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case texture
        case porosityWinter = "porosity_winter"
        case porositySummer = "porosity_summer"
        case color
    }
    
}

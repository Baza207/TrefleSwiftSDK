//
//  AreaMeasure.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct AreaMeasure: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let squareMeter: Float?
    public var acre: Float?
    
    public var description: String {
        
        if let squareMeter = self.squareMeter, let acre = self.acre {
            return "AreaMeasure(squareMeter: \(squareMeter), acre: \(acre))"
        } else {
            return "AreaMeasure()"
        }
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case squareMeter = "sqm"
        case acre
    }
    
}

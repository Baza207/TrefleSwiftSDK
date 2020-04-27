//
//  TemperatureMeasure.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct TemperatureMeasure: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let celsius: Float?
    public let fahrenheit: Float?
    
    public var description: String {
        
        if let celsius = self.celsius, let fahrenheit = self.fahrenheit {
            return "TemperatureMeasure(celsius: \(celsius), fahrenheit: \(fahrenheit))"
        } else {
            return "TemperatureMeasure()"
        }
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case celsius = "deg_c"
        case fahrenheit = "deg_f"
    }
    
}

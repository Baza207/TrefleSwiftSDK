//
//  LengthMeasure.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct LengthMeasure: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let centimeter: Float?
    private var rawInch: Float?
    public var inch: Float? {
        if let inch = rawInch {
            return inch
        } else if let foot = self.foot {
            return foot * 12
        }
        return nil
    }
    private var foot: Float?
    
    public var description: String {
        
        if let centimeter = self.centimeter, let inch = self.inch {
            return "LengthMeasure(centimeter: \(centimeter), inch: \(inch))"
        } else {
            return "LengthMeasure()"
        }
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case centimeter = "cm"
        case rawInch = "inches"
        case foot = "ft"
    }
    
}

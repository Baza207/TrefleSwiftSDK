//
//  SoilsAdaptation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum SoilAdaptation {
    case medium
    case fine
    case coarse
}

internal struct SoilAdaptationItem: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    internal let medium: Bool?
    internal let fine: Bool?
    internal let coarse: Bool?
    internal var type: SoilAdaptation? {
        if let medium = self.medium, medium == true {
            return .medium
        } else if let fine = self.fine, fine == true {
            return .fine
        } else if let coarse = self.coarse, coarse == true {
            return .coarse
        }
        return nil
    }
    
    public var description: String {
        "SoilAdaptationItem(medium: \(medium ?? false), fine: \(fine ?? false), coarse: \(coarse ?? false))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case medium
        case fine
        case coarse
    }
    
}

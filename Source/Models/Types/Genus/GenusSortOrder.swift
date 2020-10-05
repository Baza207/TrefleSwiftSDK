//
//  GenusSortOrder.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum GenusSortOrder: Hashable {
    case name
    case slug
    case familyId
    case other(String)
    
    public init(rawValue: String) {
        switch rawValue {
        case "name":
            self = .name
        case "slug":
            self = .slug
        case "family_id":
            self = .familyId
        default:
            self = .other(rawValue)
        }
    }
    
    public var rawValue: String {
        switch self {
        case .name:
            return "name"
        case .slug:
            return "slug"
        case .familyId:
            return "family_id"
        case .other(let rawValue):
            return rawValue
        }
    }
    
}

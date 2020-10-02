//
//  Distribution.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Distribution: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let native: [Zone]?
    public let introduced: [Zone]?
    public let doubtful: [Zone]?
    public let absent: [Zone]?
    public let extinct: [Zone]?
    
    public var description: String {
        "Distribution(native: \(native ?? []), introduced: \(introduced ?? []), doubtful: \(doubtful ?? []), absent: \(absent ?? []), extinct: \(extinct ?? []))"
    }
    
}

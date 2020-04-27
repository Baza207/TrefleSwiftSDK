//
//  Propagation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Propagation: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    internal let tubersOptional: Bool?
    public var tubers: Bool? { tubersOptional ?? false }
    internal let sprigsOptional: Bool?
    public var sprigs: Bool? { sprigsOptional ?? false }
    internal let sodOptional: Bool?
    public var sod: Bool? { sodOptional ?? false }
    internal let seedOptional: Bool?
    public var seed: Bool? { seedOptional ?? false }
    internal let cuttingsOptional: Bool?
    public var cuttings: Bool? { cuttingsOptional ?? false }
    internal let cormsOptional: Bool?
    public var corms: Bool? { cormsOptional ?? false }
    internal let containerOptional: Bool?
    public var container: Bool? { containerOptional ?? false }
    internal let bulbsOptional: Bool?
    public var bulbs: Bool? { bulbsOptional ?? false }
    internal let bareRootOptional: Bool?
    public var bareRoot: Bool? { bareRootOptional ?? false }
    
    public var description: String {
        "Propagation()"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case tubersOptional
        case sprigsOptional
        case sodOptional
        case seedOptional
        case cuttingsOptional
        case cormsOptional
        case containerOptional
        case bulbsOptional
        case bareRootOptional = "bare_root"
    }
    
}

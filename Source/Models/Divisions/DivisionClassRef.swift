//
//  DivisionRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct DivisionClassRef: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let slug: String
    public let name: String
    public let link: String
    
    public var description: String {
        "DivisionClassRef(identifier: \(identifier), slug: \(slug), name: \(name), link: \(link))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case slug
        case name
        case link
    }
    
}

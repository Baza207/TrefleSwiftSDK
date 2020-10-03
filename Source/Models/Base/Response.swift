//
//  Response.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-08-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct ResponseList<T: Decodable>: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let items: [T]
    public let links: Links
    public let metadata: Metadata
    
    public var description: String {
        "ResponseList(items: \(items), links: \(links), metadata: \(metadata))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case items = "data"
        case links
        case metadata = "meta"
    }
    
}

public struct ResponseSingle<T: Decodable>: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let item: T
    public let meta: Metadata
    
    public var description: String {
        "ResponseSingle(data: \(item), meta: \(meta))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case item = "data"
        case meta
    }
    
}
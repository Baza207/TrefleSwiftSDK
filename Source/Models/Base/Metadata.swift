//
//  Metadata.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-08-14.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Metadata: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let total: Int?
    public let lastModified: Date?
    
    public var description: String {
        "Metadata(total: \(total ?? -1), lastModified: \(lastModified ?? Date.distantPast)"
    }
    
    // MARK: - Init
    
    public init(total: Int? = nil, lastModified: Date? = nil) {
        self.total = total
        self.lastModified = lastModified
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case total
        case lastModified = "last_modified"
    }
    
}

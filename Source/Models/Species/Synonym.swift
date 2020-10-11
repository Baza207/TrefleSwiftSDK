//
//  Synonym.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Synonym: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: Int
    public let name: String
    public let author: String?
    
    public var description: String {
        "Synonym(identifier: \(identifier), name: \(name), author: \(author ?? "-"))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, name: String, author: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.author = author
    }
    
    internal static var blank: Self {
        Self(identifier: -1, name: "")
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case author
    }
    
}

//
//  ImageRef.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-26.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct ImageRef: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let urlString: String
    public var url: URL? { URL(string: urlString) }
    
    public var description: String {
        "PlantRef(urlString: \(urlString))"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case urlString = "url"
    }
    
}

//
//  Source.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Source: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let identifier: String?
    public let name: String
    public let urlString: String?
    public var url: URL? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)
    }
    public let lastUpdate: Date
    public let citation: String?
    
    public var description: String {
        "Source(identifier: \(identifier ?? "-"), name: \(name), citation: \(citation ?? "-"), url: \(urlString ?? "-"), lastUpdate: \(lastUpdate))"
    }
    
    // MARK: - Init
    
    public init(identifier: String? = nil, name: String, urlString: String? = nil, lastUpdate: Date, citation: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.urlString = urlString
        self.lastUpdate = lastUpdate
        self.citation = citation
    }
    
    internal static var blank: Self {
        Self(name: "", lastUpdate: Date.distantPast)
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case urlString = "url"
        case lastUpdate = "last_update"
        case citation
    }
    
}

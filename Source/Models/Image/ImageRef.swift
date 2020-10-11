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
    
    public let identifier: Int
    public let urlString: String
    public var url: URL? {
        let imageURLString: String
        if Trefle.shared.config.forceHttpsImageUrls == true {
            imageURLString = urlString.forceHttps()
        } else {
            imageURLString = urlString
        }
        return URL(string: imageURLString)
    }
    public let copyright: String?
    
    public var description: String {
        "ImageRef(identifier: \(identifier), urlString: \(urlString))"
    }
    
    // MARK: - Init
    
    public init(identifier: Int, urlString: String, copyright: String? = nil) {
        self.identifier = identifier
        self.urlString = urlString
        self.copyright = copyright
    }
    
    internal static var blank: Self {
        Self(identifier: -1, urlString: "")
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case urlString = "image_url"
        case copyright
    }
    
}

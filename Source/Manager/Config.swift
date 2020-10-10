//
//  Config.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-10.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Config {
    
    public static let `default` = Config(forceHttpsImageUrls: false)
    
    // MARK: - Properties
    
    public let forceHttpsImageUrls: Bool
    
}

//
//  Config.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-10.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension Trefle {
    
    public struct Config {
        
        public static let `default` = Config()
        
        // MARK: - Properties
        
        public let forceHttpsImageUrls: Bool
        
        // MARK: - Init
        
        public init(forceHttpsImageUrls: Bool = false) {
            self.forceHttpsImageUrls = forceHttpsImageUrls
        }
        
    }
    
}

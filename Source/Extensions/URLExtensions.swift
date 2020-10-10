//
//  URLExtensions.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-10.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension URL {
    
    internal func validateURL(forceHttps: Bool) -> Bool {
        
        switch scheme {
        case "http":
            if forceHttps == true {
                return false
            } else {
                return true
            }
        case "https":
            return true
        default:
            return false
        }
    }
    
}

extension String {
    
    internal func validateURL(forceHttps: Bool) -> Bool {
        
        if hasPrefix("http://") == true {
            if forceHttps == true {
                return false
            } else {
                return true
            }
        } else if hasPrefix("https://") == true {
            return true
        } else {
            return false
        }
    }
    
    internal func forceHttps() -> String {
        
        guard hasPrefix("http://") == true else {
            return self
        }
        
        let start = index(startIndex, offsetBy: 7)
        let end = index(endIndex, offsetBy: 0)
        let range = start..<end
        let path = self[range]
        
        return "https://\(path)"
    }
    
}

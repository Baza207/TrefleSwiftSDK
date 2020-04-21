//
//  TrefleError.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum TrefleError: Error, LocalizedError {
    case badURL
    case noData
    case generalError
    
    public var errorDescription: String? {
        
        switch self {
        case .badURL:
            return "Bad URL"
        case .noData:
            return "No Data"
        case .generalError:
            return "General Error"
        }
    }
}

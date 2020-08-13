//
//  JSONDecoderExtensions.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    internal static var customDateJSONDecoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
}

//
//  URLRequestExtensions.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension URLRequest {
    
    internal static func jsonRequest(url: URL, jwt: String, httpMethod: String? = nil) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        if let httpMethod = httpMethod {
            urlRequest.httpMethod = httpMethod
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
}

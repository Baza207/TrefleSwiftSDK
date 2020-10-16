//
//  ResponseItemPublisher.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
public extension ResponseItem {
    
    static func publisher<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<ResponseItem<T>, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ResponseItem<T>.self, decoder: JSONDecoder.customJSONDecoder)
            .eraseToAnyPublisher()
    }
    
    internal static func publisher<T: Decodable>(_ url: URL) -> AnyPublisher<ResponseItem<T>, Error> {
        
        JWTState.publisher()
            .tryMap { (jwtState) -> URLRequest in
                if jwtState.isValid == false {
                    throw TrefleError.invalidJWT
                }
                return URLRequest.jsonRequest(url: url, jwt: jwtState.jwt)
            }
            .flatMap { (urlRequest) -> AnyPublisher<ResponseItem<T>, Error> in
                ResponseItem.publisher(urlRequest)
            }
            .eraseToAnyPublisher()
    }
    
}

//
//  ResponseListPublisher.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-12.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
public extension ResponseList {
    
    internal static func publisher<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<ResponseList<T>, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ResponseList<T>.self, decoder: JSONDecoder.customJSONDecoder)
            .eraseToAnyPublisher()
    }
    
    static func publisher<T: Decodable>(_ url: URL) -> AnyPublisher<ResponseList<T>, Error> {
        
        JWTState.publisher()
            .tryMap { (jwtState) -> URLRequest in
                if jwtState.isValid == false {
                    throw TrefleError.invalidJWT
                }
                return URLRequest.jsonRequest(url: url, jwt: jwtState.jwt)
            }
            .flatMap { (urlRequest) -> AnyPublisher<ResponseList<T>, Error> in
                ResponseList.publisher(urlRequest)
            }
            .eraseToAnyPublisher()
    }
    
}

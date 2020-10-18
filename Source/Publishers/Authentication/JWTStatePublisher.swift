//
//  JWTStatePublisher.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
internal extension JWTState {
    
    static func publisher(_ urlRequest: URLRequest) -> AnyPublisher<JWTState, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: JWTState.self, decoder: JSONDecoder.jwtJSONDecoder)
            .eraseToAnyPublisher()
    }
    
    static func publisher() -> AnyPublisher<JWTState, Error> {
        
        if Trefle.shared.isValid == true {
            
            return Future<JWTState, Error> { (promise) in
                if let jwtState = Trefle.shared.jwtState {
                    promise(.success(jwtState))
                } else {
                    promise(.failure(TrefleError.noJWT))
                }
            }
            .eraseToAnyPublisher()
            
        } else {
            
            return Future<URLRequest, Error> { promise in
                if let urlRequest = JWTState.urlRequest {
                    promise(.success(urlRequest))
                }
                promise(.failure(TrefleError.badURL))
            }
            .flatMap { (urlRequest) -> AnyPublisher<JWTState, Error> in
                JWTState.publisher(urlRequest)
            }
            .eraseToAnyPublisher()
        }
    }
    
}

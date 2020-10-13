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
extension JWTState {
    
    static func publisher(_ urlRequest: URLRequest) -> AnyPublisher<JWTState, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: JWTState.self, decoder: JSONDecoder.jwtJSONDecoder)
            .eraseToAnyPublisher()
    }
    
}

//
//  ListPublisher.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-12.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
extension ResponseList {
    
    static func publisher<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<ResponseList<T>, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ResponseList<T>.self, decoder: JSONDecoder.customJSONDecoder)
            .eraseToAnyPublisher()
    }
    
}

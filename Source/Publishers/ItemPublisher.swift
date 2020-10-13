//
//  ItemPublisher.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
extension ResponseItem {
    
    static func publisher<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<ResponseItem<T>, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ResponseItem<T>.self, decoder: JSONDecoder.customJSONDecoder)
            .eraseToAnyPublisher()
    }
    
}

//
//  TrefleManagers.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-16.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

public protocol TrefleManagers {
    static func itemURL(identifier: String) -> URL?
}

@available(iOS 13, *)
public extension TrefleManagers {
    
    // MARK: - Fetch List
    
    static func fetchPublisher<T: Decodable>(url: URL) -> AnyPublisher<ResponseList<T>, Error> {
        ResponseList<T>.publisher(url)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Fetch Item
    
    static func fetchItemPublisher<T: Decodable>(identifier: String) -> AnyPublisher<ResponseItem<T>, Error> {
        
        Future<URL, Error> { (promise) in
            if let url = itemURL(identifier: identifier) {
                promise(.success(url))
            } else {
                promise(.failure(TrefleError.badURL))
            }
        }
        .flatMap { (url) -> AnyPublisher<ResponseItem<T>, Error> in
            ResponseItem<T>.publisher(url)
        }
        .eraseToAnyPublisher()
    }
    
}

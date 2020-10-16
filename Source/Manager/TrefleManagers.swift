//
//  TrefleManagers.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-16.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

typealias KingdomRefPublisher = AnyPublisher<ResponseList<KingdomRef>, Error>
typealias KingdomPublisher = AnyPublisher<ResponseItem<Kingdom>, Error>

public protocol TrefleManagers {
    static func listURL(page: Int?) -> URL?
    static func itemURL(identifier: String) -> URL?
}

@available(iOS 13, *)
public extension TrefleManagers {
    
    // MARK: - Fetch Kingdoms
    
    static func fetchPublisher<T: Decodable>(page: Int? = nil) -> AnyPublisher<ResponseList<T>, Error> {
        Future<URL, Error> { (promise) in
            if let url = listURL(page: page) {
                promise(.success(url))
            } else {
                promise(.failure(TrefleError.badURL))
            }
        }
        .flatMap { (url) -> AnyPublisher<ResponseList<T>, Error> in
            ResponseList<T>.publisher(url)
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Fetch Kingdom
    
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

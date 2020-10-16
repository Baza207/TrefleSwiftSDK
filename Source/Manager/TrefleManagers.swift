//
//  TrefleManagers.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-16.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

public typealias KingdomRefPublisher = AnyPublisher<ResponseList<KingdomRef>, Error>
public typealias KingdomPublisher = AnyPublisher<ResponseItem<Kingdom>, Error>
public typealias SubkingdomRefPublisher = AnyPublisher<ResponseList<SubkingdomRef>, Error>
public typealias SubkingdomPublisher = AnyPublisher<ResponseItem<Subkingdom>, Error>
public typealias DivisionRefPublisher = AnyPublisher<ResponseList<DivisionRef>, Error>
public typealias DivisionPublisher = AnyPublisher<ResponseItem<Division>, Error>
public typealias DivisionClassRefPublisher = AnyPublisher<ResponseList<DivisionClassRef>, Error>
public typealias DivisionClassPublisher = AnyPublisher<ResponseItem<DivisionClass>, Error>
public typealias DivisionOrderRefPublisher = AnyPublisher<ResponseList<DivisionOrderRef>, Error>
public typealias DivisionOrderPublisher = AnyPublisher<ResponseItem<DivisionOrder>, Error>

public protocol TrefleManagers {
    static func listURL(page: Int?) -> URL?
    static func itemURL(identifier: String) -> URL?
}

@available(iOS 13, *)
public extension TrefleManagers {
    
    // MARK: - Fetch List
    
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

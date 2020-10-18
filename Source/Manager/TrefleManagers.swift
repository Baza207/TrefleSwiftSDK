//
//  TrefleManagers.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-16.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
public typealias KingdomRefsPublisher = AnyPublisher<ResponseList<KingdomRef>, Error>
@available(iOS 13, *)
public typealias KingdomPublisher = AnyPublisher<ResponseItem<Kingdom>, Error>
@available(iOS 13, *)
public typealias SubkingdomRefsPublisher = AnyPublisher<ResponseList<SubkingdomRef>, Error>
@available(iOS 13, *)
public typealias SubkingdomPublisher = AnyPublisher<ResponseItem<Subkingdom>, Error>
@available(iOS 13, *)
public typealias DivisionRefsPublisher = AnyPublisher<ResponseList<DivisionRef>, Error>
@available(iOS 13, *)
public typealias DivisionPublisher = AnyPublisher<ResponseItem<Division>, Error>
@available(iOS 13, *)
public typealias DivisionClassRefsPublisher = AnyPublisher<ResponseList<DivisionClassRef>, Error>
@available(iOS 13, *)
public typealias DivisionClassPublisher = AnyPublisher<ResponseItem<DivisionClass>, Error>
@available(iOS 13, *)
public typealias DivisionOrderRefsPublisher = AnyPublisher<ResponseList<DivisionOrderRef>, Error>
@available(iOS 13, *)
public typealias DivisionOrderPublisher = AnyPublisher<ResponseItem<DivisionOrder>, Error>
@available(iOS 13, *)
public typealias FamilyRefsPublisher = AnyPublisher<ResponseList<FamilyRef>, Error>
@available(iOS 13, *)
public typealias FamilyPublisher = AnyPublisher<ResponseItem<Family>, Error>
@available(iOS 13, *)
public typealias GenusRefsPublisher = AnyPublisher<ResponseList<GenusRef>, Error>
@available(iOS 13, *)
public typealias GenusPublisher = AnyPublisher<ResponseItem<Genus>, Error>
@available(iOS 13, *)
public typealias PlantRefsPublisher = AnyPublisher<ResponseList<PlantRef>, Error>
@available(iOS 13, *)
public typealias PlantPublisher = AnyPublisher<ResponseItem<Plant>, Error>
@available(iOS 13, *)
public typealias SpeciesRefsPublisher = AnyPublisher<ResponseList<SpeciesRef>, Error>
@available(iOS 13, *)
public typealias SpeciesPublisher = AnyPublisher<ResponseItem<Species>, Error>
@available(iOS 13, *)
public typealias ZoneRefsPublisher = AnyPublisher<ResponseList<Zone>, Error>
@available(iOS 13, *)
public typealias ZonePublisher = AnyPublisher<ResponseItem<Zone>, Error>

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

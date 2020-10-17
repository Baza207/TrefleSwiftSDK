//
//  GenusManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

public class GenusManager: TrefleManagers {
    
    public typealias Filter = [GenusFilter: [String]]
    public typealias SortOrder = [(field: GenusSortOrder, order: Order)]
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/genus"
    
    // MARK: - Genus URLs
    
    public static func listURL(filter: Filter?, order: SortOrder?, page: Int?) -> URL? {
        
        guard var urlComponents = URLComponents(string: apiURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    public static func itemURL(identifier: String) -> URL? {
        URL(string: "\(apiURL)/\(identifier)")
    }
    
}

// MARK: - Operations

public extension GenusManager {
    
    // MARK: - Fetch Genus Refs
    
    @discardableResult
    static func fetch(filter: Filter? = nil, order: SortOrder? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<GenusRef>, Error>) -> Void) -> ListOperation<GenusRef>? {
        
        guard let url = listURL(filter: filter, order: order, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<GenusRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Genus
    
    @discardableResult
    static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Genus>, Error>) -> Void) -> ItemOperation<Genus>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Genus>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(itemOperation)
            return itemOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        itemOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, itemOperation], waitUntilFinished: false)
        return itemOperation
    }
    
}

// MARK: - Publishers

@available(iOS 13, *)
public extension GenusManager {
    
    // MARK: - Fetch Genus Refs
    
    static func fetchPublisher<T: Decodable>(filter: Filter? = nil, order: SortOrder? = nil, page: Int? = nil) -> AnyPublisher<ResponseList<T>, Error> {
        
        Future<URL, Error> { (promise) in
            if let url = listURL(filter: filter, order: order, page: page) {
                promise(.success(url))
            } else {
                promise(.failure(TrefleError.badURL))
            }
        }
        .flatMap { (url) -> AnyPublisher<ResponseList<T>, Error> in
            fetchPublisher(url: url)
        }
        .eraseToAnyPublisher()
    }
    
}

//
//  KingdomsManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

public class KingdomsManager {
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/kingdoms"
    
    // MARK: - Kingdoms URLs
    
    internal static func listURL(page: Int? = nil) -> URL? {
        
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
    
    internal static func itemURL(identifier: String) -> URL? {
        URL(string: "\(apiURL)/\(identifier)")
    }
    
}

// MARK: - Operations

extension KingdomsManager {
    
    // MARK: - Fetch Kingdoms
    
    @discardableResult
    public static func fetch(page: Int? = nil, completed: @escaping (Result<ResponseList<KingdomRef>, Error>) -> Void) -> ListOperation<KingdomRef>? {
        
        guard let url = listURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<KingdomRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Kingdom
    
    @discardableResult
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Kingdom>, Error>) -> Void) -> ItemOperation<Kingdom>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Kingdom>(url: url, completionBlock: completed)
        
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

extension KingdomsManager {
    
    // MARK: - Fetch Kingdoms
    
    public static func fetchPublisher(page: Int? = nil) -> AnyPublisher<ResponseList<KingdomRef>, Error> {
        Future<URL, Error> { (promise) in
            if let url = listURL(page: page) {
                promise(.success(url))
            } else {
                promise(.failure(TrefleError.badURL))
            }
        }
        .flatMap { (url) -> AnyPublisher<ResponseList<KingdomRef>, Error> in
            ResponseList<KingdomRef>.publisher(url)
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Fetch Kingdom
    
    public static func fetchItemPublisher(identifier: String) -> AnyPublisher<ResponseItem<Kingdom>, Error> {
        Future<URL, Error> { (promise) in
            if let url = itemURL(identifier: identifier) {
                promise(.success(url))
            } else {
                promise(.failure(TrefleError.badURL))
            }
        }
        .flatMap { (url) -> AnyPublisher<ResponseItem<Kingdom>, Error> in
            ResponseItem<Kingdom>.publisher(url)
        }
        .eraseToAnyPublisher()
    }
    
}

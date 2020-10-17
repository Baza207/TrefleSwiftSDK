//
//  KingdomsManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation
import Combine

public class KingdomsManager: TrefleManagers {
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/kingdoms"
    
    // MARK: - Kingdoms URLs
    
    public static func listURL(page: Int?) -> URL? {
        
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

public extension KingdomsManager {
    
    // MARK: - Fetch Kingdom Refs
    
    @discardableResult
    static func fetch(page: Int? = nil, completed: @escaping (Result<ResponseList<KingdomRef>, Error>) -> Void) -> ListOperation<KingdomRef>? {
        
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
    static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Kingdom>, Error>) -> Void) -> ItemOperation<Kingdom>? {
        
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

@available(iOS 13, *)
public extension KingdomsManager {
    
    // MARK: - Fetch Kingdom Refs
    
    static func fetchPublisher<T: Decodable>(page: Int? = nil) -> AnyPublisher<ResponseList<T>, Error> {
        
        Future<URL, Error> { (promise) in
            if let url = listURL(page: page) {
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

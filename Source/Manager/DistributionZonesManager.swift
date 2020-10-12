//
//  DistributionZonesManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class DistributionZonesManager {
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/distributions"
    
    // MARK: - Distribution Zones URLs
    
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
    
    // MARK: - Fetch Distribution Zones
    
    @discardableResult
    public static func fetch(page: Int? = nil, completed: @escaping (Result<ResponseList<Zone>, Error>) -> Void) -> ListOperation<Zone>? {
        
        guard let url = listURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<Zone>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = ClaimTokenOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Distribution Zone
    
    @discardableResult
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Zone>, Error>) -> Void) -> ItemOperation<Zone>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Zone>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(itemOperation)
            return itemOperation
        }
        
        let claimTokenOperation = ClaimTokenOperation()
        itemOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, itemOperation], waitUntilFinished: false)
        return itemOperation
    }
    
}

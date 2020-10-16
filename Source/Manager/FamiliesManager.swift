//
//  FamiliesManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class FamiliesManager {
    
    public typealias Filter = [FamilyFilter: [String]]
    public typealias SortOrder = [(field: FamilySortOrder, order: Order)]
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/families"
    
    // MARK: - Families URLs
    
    internal static func listURL(filter: Filter? = nil, order: SortOrder? = nil, page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: apiURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        filter?.forEach { (field, value) in
            let values = value.joined(separator: ",")
            queryItems.append(URLQueryItem(name: "filter[\(field.rawValue)]", value: values))
        }
        
        order?.forEach { (field, order) in
            queryItems.append(URLQueryItem(name: "order[\(field.rawValue)]", value: order.rawValue))
        }
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func itemURL(identifier: String) -> URL? {
        URL(string: "\(apiURL)/\(identifier)")
    }
    
    // MARK: - Fetch Families
    
    @discardableResult
    public static func fetch(page: Int? = nil, completed: @escaping (Result<ResponseList<FamilyRef>, Error>) -> Void) -> ListOperation<FamilyRef>? {
        
        guard let url = listURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<FamilyRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Family
    
    @discardableResult
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Family>, Error>) -> Void) -> ItemOperation<Family>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Family>(url: url, completionBlock: completed)
        
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

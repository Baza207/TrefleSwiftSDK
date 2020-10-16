//
//  PlantsManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class PlantsManager {
    
    public typealias Filter = [PlantFilter: [String]]
    public typealias Exclude = [PlantExclude]
    public typealias SortOrder = [(field: PlantSortOrder, order: Order)]
    public typealias Range = [PlantRange: String]
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/plants"
    
    // MARK: - Plant URLs
    
    internal static func listURL(query: String? = nil, zoneId: String? = nil, genusId: String? = nil, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil) -> URL? {
        
        let urlString: String
        if query != nil {
            urlString = "\(apiURL)/search"
        } else if let zoneId = zoneId {
            urlString = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/distributions/\(zoneId)/plants"
        } else if let genusId = genusId {
            urlString = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/genus/\(genusId)/plants"
        } else {
            urlString = apiURL
        }
        
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let query = query, query.isEmpty == false {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        
        filter?.forEach { (field, value) in
            let values = value.joined(separator: ",")
            queryItems.append(URLQueryItem(name: "filter[\(field.rawValue)]", value: values))
        }
        
        exclude?.forEach { (field) in
            queryItems.append(URLQueryItem(name: "filter_not[\(field.rawValue)]", value: "null"))
        }
        
        order?.forEach { (field, order) in
            queryItems.append(URLQueryItem(name: "order[\(field.rawValue)]", value: order.rawValue))
        }
        
        range?.forEach { (field, value) in
            queryItems.append(URLQueryItem(name: "range[\(field.rawValue)]", value: value))
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
    
    // MARK: - Fetch Plants
    
    @discardableResult
    public static func fetch(filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) -> ListOperation<PlantRef>? {
        
        guard let url = listURL(filter: filter, exclude: exclude, order: order, range: range, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<PlantRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Search Plants
    
    @discardableResult
    public static func search(query: String, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) -> ListOperation<PlantRef>? {
        
        guard let url = listURL(query: query, filter: filter, exclude: exclude, order: order, range: range, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<PlantRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Plants in Distribution Zone
    
    @discardableResult
    public static func fetchInDistributionZone(with zoneId: String, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) -> ListOperation<PlantRef>? {
        
        guard let url = listURL(zoneId: zoneId, filter: filter, exclude: exclude, order: order, range: range, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<PlantRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Plants of a Genus
    
    @discardableResult
    public static func fetchOfGenus(with genusId: String, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) -> ListOperation<PlantRef>? {
        
        guard let url = listURL(genusId: genusId, filter: filter, exclude: exclude, order: order, range: range, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<PlantRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = JWTStateOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Plant
    
    @discardableResult
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Plant>, Error>) -> Void) -> ItemOperation<Plant>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Plant>(url: url, completionBlock: completed)
        
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

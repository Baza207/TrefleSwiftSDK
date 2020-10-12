//
//  SpeciesManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class SpeciesManager {
    
    public typealias Filter = [SpeciesFilter: [String]]
    public typealias Exclude = [SpeciesExclude]
    public typealias SortOrder = [(field: SpeciesSortOrder, order: Order)]
    public typealias Range = [SpeciesRange: String]
    
    internal static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/species"
    
    // MARK: - Species URLs
    
    internal static func listURL(query: String? = nil, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil) -> URL? {
        
        let urlString: String
        if query != nil {
            urlString = "\(apiURL)/search"
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
            queryItems.append(URLQueryItem(name: "filter_not[\(field.rawValue)]", value: nil))
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
    
    // MARK: - Fetch Species
    
    @discardableResult
    public static func fetch(query: String? = nil, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<SpeciesRef>, Error>) -> Void) -> ListOperation<SpeciesRef>? {
        
        guard let url = listURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let listOperation = ListOperation<SpeciesRef>(url: url, completionBlock: completed)
        
        guard Trefle.shared.isValid == false else {
            
            Trefle.operationQueue.addOperation(listOperation)
            return listOperation
        }
        
        let claimTokenOperation = ClaimTokenOperation()
        listOperation.addDependency(claimTokenOperation)
        
        Trefle.operationQueue.addOperations([claimTokenOperation, listOperation], waitUntilFinished: false)
        return listOperation
    }
    
    // MARK: - Fetch Species
    
    @discardableResult
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseItem<Species>, Error>) -> Void) -> ItemOperation<Species>? {
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return nil
        }
        
        let itemOperation = ItemOperation<Species>(url: url, completionBlock: completed)
        
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

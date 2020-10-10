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
    
    public static func fetch(query: String? = nil, filter: Filter? = nil, exclude: Exclude? = nil, order: SortOrder? = nil, range: Range? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<SpeciesRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = listURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetch(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetch(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetch(jwt: String, url: URL, completed: @escaping (Result<ResponseList<SpeciesRef>, Error>) -> Void) {
        
        let urlRequest = URLRequest.jsonRequest(url: url, jwt: jwt)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(TrefleError.noData))
                return
            }
            
            let decoder = JSONDecoder.customJSONDecoder
            let result: ResponseList<SpeciesRef>?
            do {
                result = try decoder.decode(ResponseList<SpeciesRef>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let responseResult = result else {
                completed(Result.failure(TrefleError.generalError))
                return
            }
            
            completed(Result.success(responseResult))
        }
        downloadTask.resume()
    }
    
    // MARK: - Fetch Species
    
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseSingle<Species>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = itemURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchItem(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchItem(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchItem(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Species>, Error>) -> Void) {
        
        let urlRequest = URLRequest.jsonRequest(url: url, jwt: jwt)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(TrefleError.noData))
                return
            }
            
            let decoder = JSONDecoder.customJSONDecoder
            let result: ResponseSingle<Species>
            do {
                result = try decoder.decode(ResponseSingle<Species>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

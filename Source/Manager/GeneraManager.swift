//
//  GeneraManager.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class GeneraManager {
    
    public typealias Filter = [GenusFilter: [String]]
    public typealias SortOrder = [(field: GenusSortOrder, order: Order)]
    
    private static let apiURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/genus"
    
    // MARK: - Genus URLs
    
    internal static func listURL(filter: Filter? = nil, order: SortOrder? = nil, page: Int? = nil) -> URL? {
        
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
    
    // MARK: - Fetch Genus
    
    public static func fetch(page: Int? = nil, completed: @escaping (Result<ResponseList<GenusRef>, Error>) -> Void) {
        
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
    
    internal static func fetch(jwt: String, url: URL, completed: @escaping (Result<ResponseList<GenusRef>, Error>) -> Void) {
        
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
            
            let decoder = JSONDecoder.customDateJSONDecoder
            let result: ResponseList<GenusRef>?
            do {
                result = try decoder.decode(ResponseList<GenusRef>.self, from: data)
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
    
    // MARK: - Fetch Genus
    
    public static func fetchItem(identifier: String, completed: @escaping (Result<ResponseSingle<Genus>, Error>) -> Void) {
        
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

    internal static func fetchItem(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Genus>, Error>) -> Void) {
        
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
            
            let decoder = JSONDecoder.customDateJSONDecoder
            let result: ResponseSingle<Genus>
            do {
                result = try decoder.decode(ResponseSingle<Genus>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

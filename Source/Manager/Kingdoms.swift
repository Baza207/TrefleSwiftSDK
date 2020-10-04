//
//  Kingdoms.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Kingdoms {
    
    internal static let kingdomsAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/kingdoms"
    
    // MARK: - Kingdoms URLs
    
    internal static func kingdomsURL(page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: kingdomsAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func kingdomURL(identifier: String) -> URL? {
        URL(string: "\(kingdomsAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Kingdoms
    
    public static func fetchKingdoms(page: Int? = nil, completed: @escaping (Result<ResponseList<KingdomRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = kingdomsURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchKingdoms(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchKingdoms(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchKingdoms(jwt: String, url: URL, completed: @escaping (Result<ResponseList<KingdomRef>, Error>) -> Void) {
        
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
            let result: ResponseList<KingdomRef>?
            do {
                result = try decoder.decode(ResponseList<KingdomRef>.self, from: data)
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
    
    // MARK: - Fetch Kingdom
    
    public static func fetchKingdom(identifier: String, completed: @escaping (Result<ResponseSingle<Kingdom>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = kingdomURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchKingdom(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchKingdom(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchKingdom(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Kingdom>, Error>) -> Void) {
        
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
            let result: ResponseSingle<Kingdom>
            do {
                result = try decoder.decode(ResponseSingle<Kingdom>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

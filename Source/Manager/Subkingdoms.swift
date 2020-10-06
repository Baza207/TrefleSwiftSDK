//
//  Subkingdoms.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Subkingdoms {
    
    private static let subkingdomsAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/subkingdoms"
    
    // MARK: - Subkingdoms URLs
    
    internal static func subkingdomsURL(page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: subkingdomsAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func subkingdomURL(identifier: String) -> URL? {
        URL(string: "\(subkingdomsAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Subkingdoms
    
    public static func fetchSubkingdoms(page: Int? = nil, completed: @escaping (Result<ResponseList<SubkingdomRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = subkingdomsURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchSubkingdoms(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchSubkingdoms(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchSubkingdoms(jwt: String, url: URL, completed: @escaping (Result<ResponseList<SubkingdomRef>, Error>) -> Void) {
        
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
            let result: ResponseList<SubkingdomRef>?
            do {
                result = try decoder.decode(ResponseList<SubkingdomRef>.self, from: data)
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
    
    // MARK: - Fetch Subkingdom
    
    public static func fetchSubkingdom(identifier: String, completed: @escaping (Result<ResponseSingle<Subkingdom>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = subkingdomURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchSubkingdom(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchSubkingdom(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchSubkingdom(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Subkingdom>, Error>) -> Void) {
        
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
            let result: ResponseSingle<Subkingdom>
            do {
                result = try decoder.decode(ResponseSingle<Subkingdom>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

//
//  Families.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Families {
    
    public typealias Filter = [FamilyFilter: [String]]
    public typealias SortOrder = [(field: FamilySortOrder, order: Order)]
    
    private static let familiesAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/families"
    
    // MARK: - Families URLs
    
    internal static func familiesURL(filter: Filter? = nil, order: SortOrder? = nil, page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: familiesAPIURL) else {
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
    
    internal static func familyURL(identifier: String) -> URL? {
        URL(string: "\(familiesAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Families
    
    public static func fetchFamilies(page: Int? = nil, completed: @escaping (Result<ResponseList<FamilyRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = familiesURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchFamilies(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchFamilies(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchFamilies(jwt: String, url: URL, completed: @escaping (Result<ResponseList<FamilyRef>, Error>) -> Void) {
        
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
            let result: ResponseList<FamilyRef>?
            do {
                result = try decoder.decode(ResponseList<FamilyRef>.self, from: data)
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
    
    // MARK: - Fetch Family
    
    public static func fetchFamily(identifier: String, completed: @escaping (Result<ResponseSingle<Family>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = familyURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchFamily(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchFamily(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchFamily(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Family>, Error>) -> Void) {
        
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
            let result: ResponseSingle<Family>
            do {
                result = try decoder.decode(ResponseSingle<Family>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

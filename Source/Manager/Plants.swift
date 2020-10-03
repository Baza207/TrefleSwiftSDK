//
//  Plants.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Plants {
    
    internal static let plantsAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/plants"
    
    // MARK: - Plant URLs
    
    internal static func plantsURL(filter: [String: String]? = nil, exclude: [String]? = nil, order: [(field: String, order: Order)]? = nil, range: [String: String]? = nil, page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: plantsAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        filter?.forEach { (field, value) in
            queryItems.append(URLQueryItem(name: "filter[\(field)]", value: value))
        }
        
        exclude?.forEach { (field) in
            queryItems.append(URLQueryItem(name: "filter_not[\(field)]", value: nil))
        }
        
        order?.forEach { (field, order) in
            queryItems.append(URLQueryItem(name: "order[\(field)]", value: order.rawValue))
        }
        
        range?.forEach { (field, value) in
            queryItems.append(URLQueryItem(name: "range[\(field)]", value: value))
        }
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func plantURL(identifier: String) -> URL? {
        URL(string: "\(plantsAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Plants
    
    public static func fetchPlants(filter: [String: String]? = nil, exclude: [String]? = nil, order: [(field: String, order: Order)]? = nil, range: [String: String]? = nil, page: Int? = nil, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = plantsURL(filter: filter, exclude: exclude, order: order, range: range, page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            Plants.fetchPlants(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                Plants.fetchPlants(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchPlants(jwt: String, url: URL, completed: @escaping (Result<ResponseList<PlantRef>, Error>) -> Void) {
        
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
            let result: ResponseList<PlantRef>?
            do {
                result = try decoder.decode(ResponseList<PlantRef>.self, from: data)
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
    
    // MARK: - Fetch Plant
    
    public static func fetchPlant(identifier: String, completed: @escaping (Result<ResponseSingle<Plant>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = plantURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            Plants.fetchPlant(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                Plants.fetchPlant(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchPlant(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Plant>, Error>) -> Void) {
        
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
            let result: ResponseSingle<Plant>
            do {
                result = try decoder.decode(ResponseSingle<Plant>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

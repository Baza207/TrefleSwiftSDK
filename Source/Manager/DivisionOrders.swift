//
//  DivisionOrders.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class DivisionOrders {
    
    internal static let divisionOrdersAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/division_orders"
    
    // MARK: - Division Orders URLs
    
    internal static func divisionOrdersURL(page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: divisionOrdersAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func divisionOrderURL(identifier: String) -> URL? {
        URL(string: "\(divisionOrdersAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Divisions
    
    public static func fetchDivisionOrders(page: Int? = nil, completed: @escaping (Result<ResponseList<DivisionOrderRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionOrdersURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivisionOrders(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivisionOrders(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivisionOrders(jwt: String, url: URL, completed: @escaping (Result<ResponseList<DivisionOrderRef>, Error>) -> Void) {
        
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
            let result: ResponseList<DivisionOrderRef>?
            do {
                result = try decoder.decode(ResponseList<DivisionOrderRef>.self, from: data)
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
    
    // MARK: - Fetch Division Order
    
    public static func fetchDivisionOrder(identifier: String, completed: @escaping (Result<ResponseSingle<DivisionOrder>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionOrderURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivisionOrder(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivisionOrder(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivisionOrder(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<DivisionOrder>, Error>) -> Void) {
        
        print(url)
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
            let result: ResponseSingle<DivisionOrder>
            do {
                result = try decoder.decode(ResponseSingle<DivisionOrder>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

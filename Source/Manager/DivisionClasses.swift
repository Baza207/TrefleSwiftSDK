//
//  DivisionClasses.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class DivisionClasses {
    
    private static let divisionClassesAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/division_classes"
    
    // MARK: - Division Classes URLs
    
    internal static func divisionClassesURL(page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: divisionClassesAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func divisionClassURL(identifier: String) -> URL? {
        URL(string: "\(divisionClassesAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Divisions
    
    public static func fetchDivisionClasses(page: Int? = nil, completed: @escaping (Result<ResponseList<DivisionClassRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionClassesURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivisionClasses(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivisionClasses(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivisionClasses(jwt: String, url: URL, completed: @escaping (Result<ResponseList<DivisionClassRef>, Error>) -> Void) {
        
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
            let result: ResponseList<DivisionClassRef>?
            do {
                result = try decoder.decode(ResponseList<DivisionClassRef>.self, from: data)
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
    
    // MARK: - Fetch Division Class
    
    public static func fetchDivisionClass(identifier: String, completed: @escaping (Result<ResponseSingle<DivisionClass>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionClassURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivisionClass(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivisionClass(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivisionClass(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<DivisionClass>, Error>) -> Void) {
        
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
            let result: ResponseSingle<DivisionClass>
            do {
                result = try decoder.decode(ResponseSingle<DivisionClass>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

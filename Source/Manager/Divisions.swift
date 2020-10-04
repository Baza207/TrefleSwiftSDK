//
//  Divisions.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Divisions {
    
    internal static let divisionsAPIURL = "\(Trefle.baseAPIURL)/\(Trefle.apiVersion)/divisions"
    
    // MARK: - Divisions URLs
    
    internal static func divisionsURL(page: Int? = nil) -> URL? {
        
        guard var urlComponents = URLComponents(string: divisionsAPIURL) else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func divisionURL(identifier: String) -> URL? {
        URL(string: "\(divisionsAPIURL)/\(identifier)")
    }
    
    // MARK: - Fetch Divisions
    
    public static func fetchDivisions(page: Int? = nil, completed: @escaping (Result<ResponseList<DivisionRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionsURL(page: page) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivisions(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivisions(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivisions(jwt: String, url: URL, completed: @escaping (Result<ResponseList<DivisionRef>, Error>) -> Void) {
        
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
            let result: ResponseList<DivisionRef>?
            do {
                result = try decoder.decode(ResponseList<DivisionRef>.self, from: data)
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
    
    // MARK: - Fetch Division
    
    public static func fetchDivision(identifier: String, completed: @escaping (Result<ResponseSingle<Division>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = divisionURL(identifier: identifier) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            fetchDivision(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                fetchDivision(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func fetchDivision(jwt: String, url: URL, completed: @escaping (Result<ResponseSingle<Division>, Error>) -> Void) {
        
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
            let result: ResponseSingle<Division>
            do {
                result = try decoder.decode(ResponseSingle<Division>.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            completed(Result.success(result))
        }
        downloadTask.resume()
    }
    
}

//
//  Plants.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Plants {
    
    public static func getPlants(pageSize: Int? = nil, pageNumber: Int? = nil, query: String? = nil, completed: @escaping (Result<Page<PlantRef>, Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = getPlantsURL(pageSize: pageSize, pageNumber: pageNumber, query: query) else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        guard Trefle.shared.isValid == false else {
            Plants.getPlants(jwt: jwt, url: url, completed: completed)
            return
        }
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success:
                Plants.getPlants(jwt: jwt, url: url, completed: completed)
            case .failure(let error):
                completed(Result.failure(error))
            }
        }
    }
    
    internal static func getPlantsURL(pageSize: Int?, pageNumber: Int?, query: String?) -> URL? {
        
        guard var urlComponents = URLComponents(string: "\(Trefle.baseAPIURL)/plants") else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let query = query, query.isEmpty == false {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        
        if let pageSize = pageSize {
            queryItems.append(URLQueryItem(name: "page_size", value: "\(pageSize)"))
        }
        
        if let pageNumber = pageNumber {
            queryItems.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    internal static func getPlants(jwt: String, url: URL, completed: @escaping (Result<Page<PlantRef>, Error>) -> Void) {
        
        let urlRequest = URLRequest.jsonRequest(url: url, jwt: jwt)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(TrefleError.noData))
                return
            }
            
            let decoder = JSONDecoder.secondsSince1970JSONDecoder
            let result: [PlantRef]?
            do {
                result = try decoder.decode([PlantRef].self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                let page = Page(items: result ?? [], response: response)
            else {
                completed(Result.failure(TrefleError.generalError))
                return
            }
            
            completed(Result.success(page))
        }
        downloadTask.resume()
    }
    
}

//
//  Plants.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Plants {
    
    public static func getPlants(query: String? = nil, completed: @escaping (Result<[PlantRef], Error>) -> Void) {
        
        guard let jwt = Trefle.shared.jwt else {
            completed(Result.failure(TrefleError.noJWT))
            return
        }
        
        guard let url = getPlantsURL(query: query) else {
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
    
    private static func getPlantsURL(query: String?) -> URL? {
        
        guard var urlComponents = URLComponents(string: "\(Trefle.baseAPIURL)/plants") else {
            return nil
        }
        
        var queryItems = [URLQueryItem]()
        
        if let query = query, query.isEmpty == false {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    private static func getPlants(jwt: String, url: URL, completed: @escaping (Result<[PlantRef], Error>) -> Void) {
        
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
            
            completed(Result.success(result ?? []))
        }
        downloadTask.resume()
    }
    
}

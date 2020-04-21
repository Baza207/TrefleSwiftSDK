//
//  Authentication.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

extension Trefle {
    
    // MARK: - Authentication
    
    static func authorize(_ completed: ((Result<AuthState, Error>) -> Void)? = nil) {
        
        // Attempt to claim token
        Trefle.claimToken { (result) in
            
            let authState: AuthState
            switch result {
            case .success:
                authState = .authorized
            case .failure(let error):
                do {
                    try Trefle.logout()
                    authState = .failed(error)
                } catch {
                    authState = .failed(error)
                }
            }
            
            shared.authState = authState
        }
    }
    
    // MARK: - Token
    
    static internal func claimToken(_ completed: @escaping (Result<AuthState, Error>) -> Void) {
        
        // Check if JWT state is valid, otherwise refresh token
        guard shared.isValid == false else {
            
            shared.authState = .authorized
            completed(Result.success(shared.authState))
            return
        }
        
        guard var urlComponents = URLComponents(string: "\(Trefle.baseAPIURL)/api/auth/claim") else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "token", value: shared.accessToken),
            URLQueryItem(name: "origin", value: shared.uri)
        ]
        
        guard let url = urlComponents.url else {
            completed(Result.failure(TrefleError.badURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error {
                completed(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(TrefleError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            let result: JWTState?
            do {
                result = try decoder.decode(JWTState.self, from: data)
            } catch {
                completed(Result.failure(error))
                return
            }
            
            guard let jwtResult = result else {
                completed(Result.failure(TrefleError.generalError))
                return
            }
            
            guard jwtResult.isValid == true else {
                completed(Result.failure(TrefleError.generalError))
                return
            }
            
            shared.jwt = jwtResult.jwt
            shared.expires = jwtResult.expires
            
            completed(Result.success(.authorized))
        }
        downloadTask.resume()
    }
    
    // MARK: - Logout
    
    static func logout() throws {
        
        let manager = Trefle.shared
        
        if let stateUUID = manager.stateUUID {
            try KeychainPasswordItem(service: Trefle.keychainServiceName, account: stateUUID)
                .deleteItem()
        }
        
        manager.removeStateUUID()
        
        manager.jwt = nil
        manager.expires = nil
        manager.stateUUID = nil
        
        manager.authState = .unauthorized
    }
    
    // MARK: - Auth State Changed Listner
    
    typealias Listener = UUID
    
    static func addAuthStateDidChangeListener(_ callback: @escaping ((_ authState: AuthState) -> Void)) -> Listener {
        
        return Trefle.shared.authStateListenerQueue.sync(flags: .barrier) {
            
            let manager = Trefle.shared
            
            let listener = Listener()
            manager.authStateDidChangeListeners[listener] = callback

            // Perform callback with current state
            callback(manager.authState)
            
            return listener
        }
    }
    
    static func removeAuthStateDidChangeListener(with uuid: Listener) {
        
        Trefle.shared.authStateListenerQueue.async(flags: .barrier) {
            Trefle.shared.authStateDidChangeListeners.removeValue(forKey: uuid)
        }
    }
    
}

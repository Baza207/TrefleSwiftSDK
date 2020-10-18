//
//  Authentication.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public extension Trefle {
    
    // MARK: - Authentication
    
    internal static func authorize(_ completed: ((Result<AuthState, Error>) -> Void)? = nil) {
        
        // Check if JWT state is valid, otherwise refresh token
        guard shared.isValid == false else {
            
            shared.authState = .authorized
            completed?(Result.success(shared.authState))
            return
        }
        
        // Attempt to claim token
        Trefle.claimToken { (result) in
            
            switch result {
            case .success(let state):
                shared.jwtState = state
                shared.authState = .authorized
                
                guard let stateUUID = shared.stateUUID else {
                    return
                }
                
                shared.saveStateUUID(stateUUID)
                try? KeychainPasswordItem(service: Trefle.keychainServiceName, account: stateUUID)
                    .saveJSON(state)
                
            case .failure(let error):
                shared.authState = .failed(error)
                completed?(Result.failure(error))
            }
        }
    }
    
    // MARK: - Token
    
    @discardableResult
    internal static func claimToken(_ completed: @escaping (Result<JWTState, Error>) -> Void) -> JWTStateOperation {
        
        let operation = JWTStateOperation(completed)
        Trefle.operationQueue.addOperation(operation)
        return operation
    }
    
    // MARK: - Logout
    
    internal static func logout() throws {
        
        let manager = Trefle.shared
        
        if let stateUUID = manager.stateUUID {
            try KeychainPasswordItem(service: Trefle.keychainServiceName, account: stateUUID)
                .deleteItem()
        }
        
        manager.removeStateUUID()
        
        manager.jwtState = nil
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

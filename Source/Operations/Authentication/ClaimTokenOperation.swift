//
//  ClaimTokenOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class ClaimTokenOperation: Operation {
    
    internal var claimTokenCompletionBlock: ((_ result: Result<JWTState, Error>) -> Void)?
    
    private var task: URLSessionTask?
    internal var jwtState: JWTState?
    public var error: Error?
    public override var isAsynchronous: Bool { true }
    public override var isConcurrent: Bool { true }
    private var _isExecuting: Bool = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    public override var isExecuting: Bool { _isExecuting }
    private var _isFinished: Bool = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    public override var isFinished: Bool { _isFinished }
    
    internal init(_ completionBlock: ((_ result: Result<JWTState, Error>) -> Void)? = nil) {
        claimTokenCompletionBlock = completionBlock
        
        super.init()
        
        name = "com.TrefleSwiftSDK.Operation.ClaimToken"
        queuePriority = .veryHigh
    }
    
    public override func start() {
        
        if isExecuting == true {
            return
        }
        
        // Check if canceled, if so then return
        if isCancelled == true {
            
            // Finish
            _isFinished = true
            return
        }
        
        _isExecuting = true
        
        // Pre-check if JWT is still valid, if so don't claim a new token
        if Trefle.shared.isValid == true {
            jwtState = Trefle.shared.jwtState
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
        
        guard var urlComponents = URLComponents(string: "\(Trefle.baseAPIURL)/auth/claim") else {
            let error = TrefleError.badURL
            self.error = error
            
            claimTokenCompletionBlock?(Result.failure(error))
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "token", value: Trefle.shared.accessToken),
            URLQueryItem(name: "origin", value: Trefle.shared.uri)
        ]
        
        guard let url = urlComponents.url else {
            let error = TrefleError.badURL
            self.error = error
            
            claimTokenCompletionBlock?(Result.failure(error))
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
            return
        }
        
        if Trefle.shared.stateUUID == nil {
            Trefle.shared.stateUUID = UUID().uuidString
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, _, error) in
            
            guard let self = self else {
                return
            }
            
            // Check if canceled, if so then return
            if self.isCancelled == true {
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            if let error = error {
                self.error = error
                
                self.claimTokenCompletionBlock?(Result.failure(error))
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            guard let data = data else {
                let error = TrefleError.noData
                self.error = error
                
                self.claimTokenCompletionBlock?(Result.failure(error))
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            let decoder = JSONDecoder.jwtJSONDecoder
            let result: JWTState?
            do {
                result = try decoder.decode(JWTState.self, from: data)
            } catch {
                self.error = error
                
                self.claimTokenCompletionBlock?(Result.failure(error))
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            // Check if canceled, if so then return
            if self.isCancelled == true {
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            guard let jwtState = result else {
                let error = TrefleError.generalError
                self.error = error
                
                self.claimTokenCompletionBlock?(Result.failure(error))
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            guard jwtState.isValid == true else {
                let error = TrefleError.invalidToken
                self.error = error
                
                self.claimTokenCompletionBlock?(Result.failure(error))
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            self.jwtState = jwtState
            
            self.claimTokenCompletionBlock?(Result.success(jwtState))
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
        task?.resume()
    }
    
    public override func cancel() {
        super.cancel()
        
        task?.cancel()
    }
    
}

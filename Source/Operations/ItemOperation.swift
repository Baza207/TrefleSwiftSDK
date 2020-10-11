//
//  ItemOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class ItemOperation<T: Decodable>: Operation {
    
    public var fetchCompleted: ((_ result: Result<ResponseItem<T>, Error>) -> Void)?
    
    private let url: URL
    private var task: URLSessionTask?
    public var response: ResponseItem<T>?
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
    
    internal init(url: URL, completionBlock: ((_ result: Result<ResponseItem<T>, Error>) -> Void)? = nil) {
        self.url = url
        fetchCompleted = completionBlock
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
        
        guard Trefle.shared.isValid == true, let jwt = Trefle.shared.jwt else {
            error = TrefleError.noJWT
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
            return
        }
        
        let urlRequest = URLRequest.jsonRequest(url: url, jwt: jwt)
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
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            guard let data = data else {
                self.error = TrefleError.noData
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            let decoder = JSONDecoder.customJSONDecoder
            let result: ResponseItem<T>?
            do {
                result = try decoder.decode(ResponseItem<T>.self, from: data)
            } catch {
                self.error = error
                
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
            
            guard let responseResult = result else {
                self.error = TrefleError.generalError
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            self.response = responseResult
            
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

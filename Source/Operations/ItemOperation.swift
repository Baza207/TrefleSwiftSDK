//
//  ItemOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-11.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class ItemOperation<T: Decodable>: Operation {
    
    public var fetchItemCompleted: ((_ result: Result<ResponseItem<T>, Error>) -> Void)?
    
    private let jwt: String?
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
    
    internal init(jwt: String? = nil, url: URL, completionBlock: ((_ result: Result<ResponseItem<T>, Error>) -> Void)? = nil) {
        self.jwt = jwt
        self.url = url
        fetchItemCompleted = completionBlock
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
        
        guard let jwt = self.jwt ?? Trefle.shared.jwt else {
            let error = TrefleError.noJWT
            self.error = error
            
            fetchItemCompleted?(Result.failure(error))
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
            return
        }
        
        if jwt == Trefle.shared.jwt && Trefle.shared.isValid == false {
            let error = TrefleError.invalidJWT
            self.error = error
            
            fetchItemCompleted?(Result.failure(error))
            
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
            
            let decodeResult = Self.decode(data: data, error: error)
            
            // Check if canceled, if so then return
            if self.isCancelled == true {
                
                // Finish
                self._isExecuting = false
                self._isFinished = true
                return
            }
            
            switch decodeResult {
            case .success(let response):
                self.response = response
                self.fetchItemCompleted?(Result.success(response))
            case .failure(let error):
                self.error = error
                self.fetchItemCompleted?(Result.failure(error))
            }
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
        task?.resume()
    }
    
    internal static func decode(data: Data?, error: Error?) -> Result<ResponseItem<T>, Error> {
        
        if let error = error {
            return .failure(error)
        }
        
        guard let data = data else {
            return .failure(TrefleError.noData)
        }
        
        let decoder = JSONDecoder.customJSONDecoder
        let result: ResponseItem<T>?
        do {
            result = try decoder.decode(ResponseItem<T>.self, from: data)
        } catch {
            return .failure(error)
        }
        
        guard let responseResult = result else {
            return .failure(TrefleError.generalError)
        }
        
        return .success(responseResult)
    }
    
    public override func cancel() {
        super.cancel()
        
        task?.cancel()
    }
    
}

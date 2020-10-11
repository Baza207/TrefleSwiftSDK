//
//  PlantOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class PlantOperation: Operation {
    
    public var plantCompletionBlock: ((_ result: Result<ResponseItem<Plant>, Error>) -> Void)?
    
    public var identifier: String
    public var response: ResponseItem<Plant>?
    public var error: Error?
    public override var isAsynchronous: Bool {
        return true
    }
    public override var isConcurrent: Bool {
        return true
    }
    private var _isExecuting: Bool = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    public override var isExecuting: Bool {
        return _isExecuting
    }
    private var _isFinished: Bool = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    public override var isFinished: Bool {
        return _isFinished
    }
    
    public init(identifier: String, completionBlock: ((_ result: Result<ResponseItem<Plant>, Error>) -> Void)? = nil) {
        self.identifier = identifier
        self.plantCompletionBlock = completionBlock
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
        
        PlantsManager.fetchItem(identifier: identifier) { [weak self] (result) in
            
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
            
            switch result {
            case .success(let response):
                self.response = response
            case .failure(let error):
                self.error = error
            }
            
            self.plantCompletionBlock?(result)
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
    }
    
}

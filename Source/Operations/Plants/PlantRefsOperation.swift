//
//  PlantRefsOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-25.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class PlantRefsOperation: Operation {
    
    public var plantRefsCompletionBlock: ((_ result: Result<Page<PlantRef>, Error>) -> Void)?
    public var pageSize: Int?
    public var pageNumber: Int?
    public var query: String
    public var page: Page<PlantRef>?
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
    
    public init(pageSize: Int? = nil, pageNumber: Int? = nil, query: String, completionBlock: ((_ result: Result<Page<PlantRef>, Error>) -> Void)? = nil) {
        self.pageSize = pageSize
        self.pageNumber = pageNumber
        self.query = query
        self.plantRefsCompletionBlock = completionBlock
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
        
        Plants.getPlants(pageSize: pageSize, page: pageNumber, query: query) { [weak self] (result) in
            
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
            case .success(let page):
                self.page = page
            case .failure(let error):
                self.error = error
            }
            
            self.plantRefsCompletionBlock?(result)
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
    }
    
}

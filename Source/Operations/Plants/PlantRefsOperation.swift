//
//  PlantRefsOperation.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-25.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class PlantRefsOperation: Operation {
    
    public var plantRefsCompletionBlock: ((_ result: Result<ResponseList<PlantRef>, Error>) -> Void)?
    
    public let filter: PlantsManager.Filter?
    public let exclude: PlantsManager.Exclude?
    public let order: PlantsManager.SortOrder?
    public let range: PlantsManager.Range?
    public let page: Int?
    public var response: ResponseList<PlantRef>?
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
    
    public init(filter: PlantsManager.Filter? = nil, exclude: PlantsManager.Exclude? = nil, order: PlantsManager.SortOrder? = nil, range: PlantsManager.Range? = nil, page: Int? = nil, completionBlock: ((_ result: Result<ResponseList<PlantRef>, Error>) -> Void)? = nil) {
        self.filter = filter
        self.exclude = exclude
        self.order = order
        self.range = range
        self.page = page
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
        
        PlantsManager.fetch(filter: filter, exclude: exclude, order: order, range: range, page: page) { [weak self] (result) in
            
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
            
            self.plantRefsCompletionBlock?(result)
            
            // Finish
            self._isExecuting = false
            self._isFinished = true
        }
    }
    
}

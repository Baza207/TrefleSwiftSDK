//
//  Page.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Page<T> {
    
    // MARK: - Properties
    
    public let pageNumber: Int
    public let perPage: Int
    public let total: Int
    public let totalPages: Int
    public let items: [T]
    
    internal init?(items: [T], response: HTTPURLResponse) {
        
        guard
            let pageNumberString = response.allHeaderFields["page-number"] as? String,
            let pageNumber = Int(pageNumberString),
            let perPageString = response.allHeaderFields["per-page"] as? String,
            let perPage = Int(perPageString),
            let totalString = response.allHeaderFields["total"] as? String,
            let total = Int(totalString),
            let totalPagesString = response.allHeaderFields["total-pages"] as? String,
            let totalPages = Int(totalPagesString)
        else {
            return nil
        }
        
        self.items = items
        self.pageNumber = pageNumber
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
    }
}

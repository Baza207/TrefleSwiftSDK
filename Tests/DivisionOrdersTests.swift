//
//  DivisionOrdersTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class DivisionOrdersTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    func testFetchDivisionOrderRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = DivisionOrders.divisionOrdersURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        DivisionOrders.fetchDivisionOrders(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let page):
                XCTAssert(page.items.count > 0, "No returned items!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchDivisionOrderRefsPage() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = DivisionOrders.divisionOrdersURL(page: 2) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        DivisionOrders.fetchDivisionOrders(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                
                guard let comps = URLComponents(string: response.links.current) else {
                    XCTFail("Couldn't get components from current URL link.")
                    return
                }
                
                guard let pageItem = comps.queryItems?.first(where: { (item) -> Bool in
                    item.name == "page"
                }), let pageString = pageItem.value, let page = Int(pageString) else {
                    XCTFail("Couldn't get page query from current URL link.")
                    return
                }
                
                XCTAssert(page == 2, "Wrong page returned!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchDivisionOrder() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = DivisionOrders.divisionOrderURL(identifier: config.divisionOrderId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        DivisionOrders.fetchDivisionOrder(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.identifier == Int(config.divisionOrderId), "Returned item '\(response.item.identifier)' should match the fetched division order ID '\(config.divisionOrderId)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}
//
//  SubkingdomsTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class SubkingdomsTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    func testFetchSubkingdomRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SubkingdomsManager.listURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = ListOperation<SubkingdomRef>(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let page):
                XCTAssert(page.items.count > 0, "No returned items!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        Trefle.operationQueue.addOperation(operation)
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchSubkingdom() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SubkingdomsManager.itemURL(identifier: config.kingdomId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = ItemOperation<Subkingdom>(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.identifier == Int(config.subkingdomId), "Returned item '\(response.item.identifier)' should match the fetched subkingdom ID '\(config.subkingdomId)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        Trefle.operationQueue.addOperation(operation)
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

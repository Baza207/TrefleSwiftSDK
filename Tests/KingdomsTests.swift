//
//  KingdomsTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class KingdomsTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    func testFetchKingdomRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = KingdomsManager.listURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        KingdomsManager.fetch(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testFetchKingdom() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = KingdomsManager.itemURL(identifier: config.kingdomId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        KingdomsManager.fetchItem(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.identifier == Int(config.kingdomId), "Returned item '\(response.item.identifier)' should match the fetched kingdom ID '\(config.kingdomId)'!")
                
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

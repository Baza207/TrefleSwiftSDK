//
//  KingdomsPublisherTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-04.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

@available(iOS 13, *)
class KingdomsPublisherTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let state = JWTState(jwt: config.accessToken, expires: Date.distantFuture)
        Trefle.shared.jwtState = state
    }
    
    override class func tearDown() {
        Trefle.shared.jwtState = nil
    }
    
    func testFetchKingdomRefsPublisher() throws {
        
        guard let url = KingdomsManager.listURL(page: nil) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: KingdomRefsPublisher = KingdomsManager.fetchPublisher(url: url)
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.items.count > 0, "No returned items!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchKingdomPublisher() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: KingdomPublisher = KingdomsManager.fetchItemPublisher(identifier: config.kingdomId)
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.item.identifier == Int(config.kingdomId), "Returned item '\(response.item.identifier)' should match the fetched kingdom ID '\(config.kingdomId)'!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

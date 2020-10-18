//
//  FamilyPublisherTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

@available(iOS 13, *)
class FamilyPublisherTests: XCTestCase {
    
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
    
    func testFetchFamilyRefsPublisher() throws {
        
        let expectation = self.expectation(description: #function)
        
        let publisher: FamilyRefsPublisher = FamiliesManager.fetchPublisher()
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
    
    func testFetchFamilyRefsPublisherFilter() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: FamilyRefsPublisher = FamiliesManager.fetchPublisher(filter: [.name: [config.familyName]])
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.items.contains(where: { $0.name.lowercased() == config.familyName.lowercased() }), "Returned items should have the name of '\(config.familyName)' but it wasn't found in '\(response.items)'!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchFamilyRefsPublisherPage() throws {
        
        let requstedPage = 2
        
        let expectation = self.expectation(description: #function)
        
        let publisher: FamilyRefsPublisher = FamiliesManager.fetchPublisher(page: requstedPage)
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                guard let page = response.links.currentPage else {
                    XCTFail("Couldn't get page query from current URL link.")
                    return
                }
                XCTAssert(page == requstedPage, "Wrong page returned!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchFamilyPublisher() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: FamilyPublisher = FamiliesManager.fetchItemPublisher(identifier: config.familyId)
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.item.identifier == Int(config.familyId), "Returned item '\(response.item.identifier)' should match the fetched division order ID '\(config.familyId)'!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

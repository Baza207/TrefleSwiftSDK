//
//  GenusPublisherTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

@available(iOS 13, *)
class GenusPublisherTests: XCTestCase {
    
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
    
    func testFetchGenusRefsPublisher() throws {
        
        let expectation = self.expectation(description: #function)
        
        let publisher: GenusRefsPublisher = GenusManager.fetchPublisher()
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
    
    func testFetchGenusRefsPublisherFilter() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: GenusRefsPublisher = GenusManager.fetchPublisher(filter: [.name: [config.genusName]])
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.items.contains(where: { $0.name.lowercased() == config.genusName.lowercased() }), "Returned items should have the name of '\(config.genusName)' but it wasn't found in '\(response.items)'!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchGenusRefsPublisherPage() throws {
        
        let requstedPage = 2
        
        let expectation = self.expectation(description: #function)
        
        let publisher: GenusRefsPublisher = GenusManager.fetchPublisher(page: requstedPage)
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
    
    func testFetchGenusPublisher() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let publisher: GenusPublisher = GenusManager.fetchItemPublisher(identifier: config.genusId)
        let cancelable = publisher
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                XCTAssert(response.item.identifier == Int(config.genusId), "Returned item '\(response.item.identifier)' should match the fetched genus ID '\(config.genusId)'!")
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

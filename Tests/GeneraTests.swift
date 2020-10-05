//
//  GeneraTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-05.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class GeneraTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    func testFetchGenusRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Genera.generaURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Genera.fetchGenera(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testFetchGenusRefsPage() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Genera.generaURL(page: 2) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Genera.fetchGenera(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testFetchGenus() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Genera.genusURL(identifier: config.genusId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Genera.fetchGenus(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.identifier == Int(config.genusId), "Returned item '\(response.item.identifier)' should match the fetched genus ID '\(config.genusId)'!")
                
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

//
//  SpeciesTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-10-06.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class SpeciesTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    func testFetchSpeciesRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SpeciesManager.listURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        SpeciesManager.fetchList(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testGetSpeciesRefsFilter() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SpeciesManager.listURL(filter: [.commonName: [config.commonName]]) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        SpeciesManager.fetchList(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.items.contains(where: { $0.commonName?.lowercased() == config.commonName.lowercased() }), "Returned items should have the common name of '\(config.commonName)' but it wasn't found in '\(response.items)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetSpeciesRefsPage() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SpeciesManager.listURL(page: 2) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        SpeciesManager.fetchList(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testSearchSpeciesRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SpeciesManager.listURL(query: config.commonName) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        SpeciesManager.fetchList(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.items.contains(where: { $0.commonName?.lowercased() == config.commonName.lowercased() }), "Returned items should have the common name of '\(config.commonName)' but it wasn't found in '\(response.items)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testFetchSpecies() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = SpeciesManager.itemURL(identifier: config.speciesId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        SpeciesManager.fetchItem(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.identifier == Int(config.speciesId), "Returned item '\(response.item.identifier)' should match the fetched species ID '\(config.speciesId)'!")
                
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

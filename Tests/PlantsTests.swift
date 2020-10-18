//
//  PlantsTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-04-22.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class PlantsTests: XCTestCase {
    
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
    
    func testGetPlantRefs() throws {
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetch { (result) in
            
            switch result {
            case .success(let page):
                XCTAssert(page.items.count > 0, "No returned items!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlantRefsFilter() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetch(filter: [.commonName: [config.commonName]]) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.items.contains(where: { $0.commonName?.lowercased() == config.commonName.lowercased() }), "Returned items should have the common name of '\(config.commonName)' but it wasn't found in '\(response.items)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlantRefsExcludeURL() throws {
        
        guard let url = PlantsManager.listURL(filter: nil, exclude: [.toxicity], order: nil, range: nil, page: nil) else {
            XCTFail("Failed to create URL!")
            return
        }
        dump(url)
        
        guard
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = urlComponents.queryItems
        else {
            XCTAssert(false, "Couldn't get URL components from URL!")
            return
        }
        
        let queryItem = URLQueryItem(name: "filter_not[\(PlantExclude.toxicity.rawValue)]", value: "null")
        let item = queryItems.first(where: { $0 == queryItem })
        
        XCTAssert(item != nil && item?.value == "null", "Query `filter_not` should contain `null` string as a value.")
    }
    
    func testGetPlantRefsPage() throws {
        
        let requstedPage = 2
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetch(page: requstedPage) { (result) in
            
            switch result {
            case .success(let response):
                
                guard let page = response.links.currentPage else {
                    XCTFail("Couldn't get page query from current URL link.")
                    return
                }
                
                XCTAssert(page == requstedPage, "Wrong page returned!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testSearchPlantRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.search(query: config.commonName) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.items.contains(where: { $0.commonName?.lowercased() == config.commonName.lowercased() }), "Returned items should have the common name of '\(config.commonName)' but it wasn't found in '\(response.items)'!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlantRefsInDistributionZone() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetchInDistributionZone(with: config.twdgCode) { (result) in
            
            switch result {
            case .success(let page):
                XCTAssert(page.items.count > 0, "No returned items!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlantRefsOfGenus() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetchOfGenus(with: config.genusId) { (result) in
            
            switch result {
            case .success(let page):
                XCTAssert(page.items.count > 0, "No returned items!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlant() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        let operation = PlantsManager.fetchItem(identifier: config.plantId) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.mainSpeciesId == Int(config.plantId), "Returned item should match the fetched plant ID!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            operation?.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

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
    
    func testGetPlantRefs() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Plants.plantsURL() else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Plants.fetchPlants(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testGetPlantRefsPage() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Plants.plantsURL(page: 2) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Plants.fetchPlants(jwt: config.accessToken, url: url) { (result) in
            
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
    
    func testGetPlantRefsQueryPrams() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Plants.plantsURL(filter: ["common_name": config.commonName]) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Plants.fetchPlants(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.items.contains(where: { $0.commonName == config.commonName }), "Returned items should have the common name of '\(config.commonName)')!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func testGetPlant() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        guard let url = Plants.plantURL(identifier: config.plantId) else {
            XCTFail("Failed to create URL!")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Plants.fetchPlant(jwt: config.accessToken, url: url) { (result) in
            
            switch result {
            case .success(let response):
                XCTAssert(response.item.mainSpeciesId == Int(config.plantId), "Returned item should match the fetched plant ID!")
                
            case .failure(let error):
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        XCTFail(context.debugDescription)
                    case .keyNotFound(_, let context):
                        XCTFail(context.debugDescription)
                    case .typeMismatch(_, let context):
                        XCTFail(context.debugDescription)
                    case .valueNotFound(_, let context):
                        XCTFail(context.debugDescription)
                    @unknown default:
                        XCTFail(error.localizedDescription)
                    }
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

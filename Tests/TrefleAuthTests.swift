//
//  TrefleAuthTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

class TrefleSwiftSDKTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        reset()
    }
    
    func testConfigure() throws {
        
        guard let config = self.config else {
            XCTFail("Requires a test config to be setup before calling login!")
            return
        }
        
        Trefle.configure(accessToken: config.accessToken, uri: config.uri)
        
        guard Trefle.shared.isValid == false else {
            XCTFail("Already valid")
            return
        }
        
        let expectation = self.expectation(description: #function)
        
        Trefle.claimToken { (result) in
            
            switch result {
            case .success(let state):
                XCTAssertTrue(state.isValid == true)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
    func reset() {
        
        guard let userDefaults = UserDefaults(suiteName: Trefle.userDefaultsSuiteName) else {
            XCTFail("Failed to reset!")
            return
        }
        
        guard let stateUUID = userDefaults.object(forKey: Trefle.userDefaultsKeychainStateUUID) as? String else {
            return
        }
        
        userDefaults.removeObject(forKey: Trefle.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        
        try? KeychainPasswordItem(service: Trefle.keychainServiceName, account: stateUUID)
            .deleteItem()
    }
    
}

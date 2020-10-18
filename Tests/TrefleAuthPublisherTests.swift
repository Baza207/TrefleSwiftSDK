//
//  TrefleAuthPublisherTests.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import XCTest
@testable import TrefleSwiftSDK

@available(iOS 13, *)
class TrefleAuthPublisherTests: XCTestCase {
    
    var config = try? TestConfig.load()
    
    override func setUp() {
        
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
    
    override class func tearDown() {
        Trefle.shared.jwtState = nil
    }
    
    func testConfigurePublisher() throws {
        
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
        
        let cancelable = JWTState.publisher()
            .sink { (completion) in
                if let error = completion as? Error {
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            } receiveValue: { (state) in
                XCTAssertTrue(state.isValid == true)
            }
        
        waitForExpectations(timeout: 60) { (error) in
            cancelable.cancel()
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
    }
    
}

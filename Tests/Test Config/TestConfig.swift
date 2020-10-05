//
//  TestConfig.swift
//  TrefleSwiftSDKTests
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

private class TestConfigBundleClass { }

struct TestConfig: Decodable {
    
    // MARK: - Properties
    
    let accessToken: String
    let uri: String
    let kingdomId: String
    let subkingdomId: String
    let divisionId: String
    let divisionClassId: String
    let divisionOrderId: String
    let familyId: String
    let commonName: String
    let plantId: String
    
    static func load(_ overrideUrl: URL? = nil) throws -> TestConfig? {
        
        let url: URL
        if let overrideUrl = overrideUrl {
            url = overrideUrl
        } else if let defaultUrl = Bundle(for: TestConfigBundleClass.self).url(forResource: "TestConfig", withExtension: "json") {
            url = defaultUrl
        } else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        return try decoder.decode(TestConfig.self, from: data)
    }
    
}

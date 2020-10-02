//
//  Images.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Images: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let flower: [ImageRef]
    public let leaf: [ImageRef]
    public let habit: [ImageRef]
    public let fruit: [ImageRef]
    public let bark: [ImageRef]
    public let other: [ImageRef]
    
    public var description: String {
        "Images(flower: \(flower), leaf: \(leaf), habit: \(habit), fruit: \(fruit), bark: \(bark), other: \(other))"
    }
    
}

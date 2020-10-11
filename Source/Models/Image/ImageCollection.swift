//
//  ImageCollection.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-01.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct ImageCollection: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let flower: [ImageRef]
    public let leaf: [ImageRef]
    public let habit: [ImageRef]
    public let fruit: [ImageRef]
    public let bark: [ImageRef]
    public let other: [ImageRef]
    
    public var description: String {
        "ImageCollection(flower: \(flower), leaf: \(leaf), habit: \(habit), fruit: \(fruit), bark: \(bark), other: \(other))"
    }
    
    // MARK: - Init
    
    public init(flower: [ImageRef], leaf: [ImageRef], habit: [ImageRef], fruit: [ImageRef], bark: [ImageRef], other: [ImageRef]) {
        self.flower = flower
        self.leaf = leaf
        self.habit = habit
        self.fruit = fruit
        self.bark = bark
        self.other = other
    }
    
    internal static var blank: Self {
        Self(flower: [], leaf: [], habit: [], fruit: [], bark: [], other: [])
    }
    
}

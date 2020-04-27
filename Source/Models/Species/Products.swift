//
//  Products.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-27.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Products: Decodable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let veneer: String?
    public let pulpwood: String?
    public let proteinPotential: String?
    public let post: String?
    public let palatableHuman: String?
    public let palatableGrazeAnimal: String?
    public let palatableBrowseAnimal: String?
    private let nurseryStockOptional: Bool?
    public var nurseryStock: Bool { nurseryStockOptional ?? false }
    public let navalStore: String?
    public let lumber: String?
    public let fuelwood: String?
    public let fodder: String?
    public let christmasTree: String?
    public let berryNutSeed: String?
    
    public var description: String {
        "Products()"
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case veneer
        case pulpwood
        case proteinPotential = "protein_potential"
        case post
        case palatableHuman = "palatable_human"
        case palatableGrazeAnimal = "palatable_graze_animal"
        case palatableBrowseAnimal = "palatable_browse_animal"
        case nurseryStockOptional = "nursery_stock"
        case navalStore = "naval_store"
        case lumber
        case fuelwood
        case fodder
        case christmasTree = "christmas_tree"
        case berryNutSeed = "berry_nut_seed"
    }
    
}

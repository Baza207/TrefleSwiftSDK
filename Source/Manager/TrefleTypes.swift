//
//  TrefleTypes.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-10-02.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public enum Status: String, Decodable {
    case accepted
    case unknown
}

public enum Rank: String, Decodable {
    case species
    case ssp
    case `var`
    case form
    case hybrid
    case subvar
}

public enum Duration: String, Decodable {
    case annual
    case biennial
    case perennial
}

public enum EdiblePart: String, Decodable {
    case roots
    case stem
    case leaves
    case flowers
    case fruits
    case seeds
    case tubers
}

public enum LigneousType: String, Decodable {
    case liana
    case subshrub
    case shrub
    case tree
    case parasite
}

public enum Toxicity: String, Decodable {
    case none
    case low
    case medium
    case high
}

public enum Month: String, Decodable {
    case january = "jan"
    case febuary = "feb"
    case march = "mar"
    case april = "apr"
    case may = "may"
    case june = "jun"
    case july = "jul"
    case august = "aug"
    case september = "sep"
    case october = "oct"
    case november = "nov"
    case december = "dec"
}

public enum Color: String, Decodable {
    case white
    case red
    case brown
    case orange
    case yellow
    case lime
    case green
    case cyan
    case blue
    case purple
    case magenta
    case grey
    case black
}

public enum Texture: String, Decodable {
    case fine
    case medium
    case coarse
}

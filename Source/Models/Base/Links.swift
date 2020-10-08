//
//  Links.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-08-14.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public struct Links: Codable, CustomStringConvertible {
    
    // MARK: - Properties
    
    public let current: String
    public var currentPage: Int? {
        page(in: current)
    }
    public let first: String?
    public var firstPage: Int? {
        page(in: first)
    }
    public let last: String?
    public var lastPage: Int? {
        page(in: last)
    }
    public let previous: String?
    public var previousPage: Int? {
        page(in: previous)
    }
    public let next: String?
    public var nextPage: Int? {
        page(in: next)
    }
    public let kingdom: String?
    public let subkingdom: String?
    public let division: String?
    public let divisionClass: String?
    public let divisionOrder: String?
    public let family: String?
    public let genus: String?
    public let plant: String?
    public let species: String?
    
    public var description: String {
        "Links(current: \(current))"
    }
    
    // MARK: - Init
    
    init(current: String, first: String? = nil, last: String? = nil, previous: String? = nil, next: String? = nil, kingdom: String? = nil, subkingdom: String? = nil, division: String? = nil, divisionClass: String? = nil, divisionOrder: String? = nil, family: String? = nil, genus: String? = nil, plant: String? = nil, species: String? = nil) {
        self.current = current
        self.first = first
        self.last = last
        self.previous = previous
        self.next = next
        self.kingdom = kingdom
        self.subkingdom = subkingdom
        self.division = division
        self.divisionClass = divisionClass
        self.divisionOrder = divisionOrder
        self.family = family
        self.genus = genus
        self.plant = plant
        self.species = species
    }
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case current = "self"
        case first
        case last
        case previous = "prev"
        case next
        
        case kingdom
        case subkingdom
        case division
        case divisionClass = "division_class"
        case divisionOrder = "division_order"
        case family
        case genus
        case plant
        case species
    }
    
    // MARK: - Helpers
    
    internal func page(in urlString: String?) -> Int? {
        
        guard
            let urlString = urlString,
            let comps = URLComponents(string: urlString),
            let pageItem = comps.queryItems?.first(where: { $0.name == "page" }),
            let pageString = pageItem.value, let page = Int(pageString)
        else {
            return nil
        }
        return page
    }
    
}

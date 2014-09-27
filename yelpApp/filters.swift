//
//  filters.swift
//  yelpApp
//
//  Created by Deepak on 9/25/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import Foundation

class Filters {
    
    
    var isbestDeal    : Bool?
    var radius        : Int?
    var sortBy        : Int?
    var categoriesDictionary      : [String:Bool]?
    
    
    init(isbestDeal: Bool!, radius: Int!, sortBy: Int!, categoriesDictionary: [String:Bool]!) {
        self.isbestDeal = isbestDeal
        self.radius = radius
        self.sortBy = sortBy
        self.categoriesDictionary = categoriesDictionary
    }
    
    init() {
    }
}
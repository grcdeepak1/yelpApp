//
//  Restaurant.swift
//  yelpApp
//
//  Created by Deepak on 9/25/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    var name        : String!
    var thumbUrl    : String!
    var ratingUrl   : String!
    var numReviews  : Int!
    var categories  : String!   = ""
    var address     : String!   = ""
    var addressItem : String!   = ""
    var categoryItem: String!   = ""
    var BusinessViewController : ViewController!
    
    init(dictionary: NSDictionary) {
        var json        = JSON(object: dictionary)
        name            = json["name"].stringValue
        thumbUrl        = json["image_url"].stringValue
        ratingUrl       = json["rating_img_url"].stringValue
        numReviews      = json["review_count"].integerValue
        
        //Address
        if let addressArray = json["location"]["display_address"].arrayValue {
            for item in addressArray {
                if(address != "") {
                    addressItem = ", " + item.stringValue!
                } else {
                    addressItem = item.stringValue!
                }
                address = address + addressItem
            }
        }
        
        //Categories
        if let categoryArray = json["categories"].arrayValue {
            for item in categoryArray {
                if(categories != "") {
                    categoryItem = ", " + item[0].stringValue!
                } else {
                    categoryItem = item[0].stringValue!
                }
                categories = categories + categoryItem
            }
        }
    }
    
    class func searchWithQuery(query : String, completion : (Restaurants: [Restaurant]!, error: NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(query, success: {
            (operation : AFHTTPRequestOperation! , response :AnyObject!) -> Void in
            //println(response)
            var restaurantDictionaries = (response as NSDictionary)["businesses"] as [NSDictionary]
            var restaurants = restaurantDictionaries.map { (business : NSDictionary) -> Restaurant in
                Restaurant(dictionary: business)
            }
            completion(Restaurants: restaurants, error: nil)
            }) { (operation : AFHTTPRequestOperation! , error :NSError!) -> Void in
                println(error)
            }
    }
}


//
//  yelpClient.swift
//  yelpApp
//
//  Created by Deepak on 9/24/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import Foundation
import UIKit

let yelpConsumerKey    = "NwlgK2WdEuPXN5-g6KYTsA"
let yelpConsumerSecret = "EWFunrsvK2cqiJZ08E__g6ajqBM"
let yelpToken          = "3bRI-b5gaFIYnh05ZbnwdPFSkB4bq9pQ"
let yelpTokenSecret    = "mGZE5f3kL-rWIucoYyZTcf2nWCw"

func + <K,V> (left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    var vc : ViewController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class var sharedInstance : YelpClient {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : YelpClient? = nil
        }
        dispatch_once(&Static.token) {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        return Static.instance!
    }

    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        var parameters = ["term": term, "location": "San Francisco"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
    func searchWithFilters(term: String, filter: NSDictionary, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "San Francisco"] as NSDictionary
        var filterParams = parameters + filter
        println(filterParams)
        return self.GET("search", parameters: filterParams, success: success, failure: failure)
    }
    
    func yelpQuery(term: String, filter: Dictionary <String, String> ) -> Void {
        if filter.isEmpty {
        }
    }

    
}
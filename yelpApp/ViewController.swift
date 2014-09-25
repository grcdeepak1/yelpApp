//
//  ViewController.swift
//  yelpApp
//
//  Created by Deepak on 9/24/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var restaurants : [Restaurant] = []
    //var errror : NSError
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        //Restaurant.searchWithQuery("Thai",completion: (Restaurants: [Restaurant], error: NSError) -> Void in )
        YelpClient.sharedInstance.searchWithTerm("Thai", success: {
            (operation : AFHTTPRequestOperation! , response :AnyObject!) -> Void in
            //println(response)
            var restaurantDictionaries = (response as NSDictionary)["businesses"] as [NSDictionary]
            //println(restaurantDictionaries)

            self.restaurants = restaurantDictionaries.map { (business : NSDictionary) -> Restaurant in
                Restaurant(dictionary: business)
            }
            println(self.restaurants.count)
            self.tableView.reloadData()
            
            }) { (operation : AFHTTPRequestOperation! , error :NSError!) -> Void in
                println(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(restaurants.count)
        return self.restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("restaurantCell") as RestaurantCell
        //println(self.restaurants)
        cell.restaurant = self.restaurants[indexPath.row]
        return cell
    }


}


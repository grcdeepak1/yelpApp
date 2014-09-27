//
//  FiltersViewController.swift
//  yelpApp
//
//  Created by Deepak on 9/25/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func searchTermDidChange(filtersobj : Filters) -> Void
}


class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterSwitchCellDelegate {
    
    var delegate: FilterViewControllerDelegate?
    var filtersObj : Filters = Filters()
    
    @IBOutlet var filtersTableView: UITableView!
    

    var sections = ["Price",
        "Most Popular",
        "Radius",
        "Sort By",
        "General Features"]
    
    var radius = ["2 blocks",
        "6 blocks",
        "1 mile",
        "5 miles"]
    
    var sortBy = ["Best Match",
        "Distance",
        "Rating"]
    
    var categories = ["Bakeries",
        "Beer, Wine & Spirits",
        "Beverage Store",
        "Breweries",
        "Coffee & Tea",
        "Convenience Stores",
        "Desserts",
        "Farmers Market",
        "Food Delivery Services",
        "Food Trucks",
        "Grocery",
        "Ice Cream & Frozen Yogurt",
        "Juice Bars & Smoothies",
        "Specialty Food"]
    
    var isExpanded : [String:Bool]! = [String:Bool]()
    
    var isCategoriesVisible = false

    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFilterSearch(sender: AnyObject) {
        delegate?.searchTermDidChange(self.filtersObj)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filtersTableView.dataSource = self
        self.filtersTableView.delegate = self
        //filtersTableView.rowHeight = UITableViewAutomaticDimension
        isCategoriesVisible = false
        
        self.navigationItem.title = "Filters"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()

        var categoriesDictionary = [self.categories[0]  : false,
            self.categories[1]  : false,
            self.categories[2]  : false,
            self.categories[3]  : false,
            self.categories[4]  : false,
            self.categories[5]  : false,
            self.categories[6]  : false,
            self.categories[7]  : false,
            self.categories[8]  : false,
            self.categories[9]  : false,
            self.categories[10] : false,
            self.categories[11] : false,
            self.categories[12] : false,
            self.categories[13] : false]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        var headerLabel = UILabel(frame: CGRect(x: 10, y: -15, width: 320, height: 50))
        
        headerLabel.text = sections[section]
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            //Price
            return 1
        case 1:
            //Most Popular
            return 1
        case 2:
            //Radius
            if let expanded = isExpanded[self.sections[section]] {
                return expanded ? self.radius.count : 1
            } else {
                return 1
            }
            
        case 3:
            //Sort By
            if let expanded = isExpanded[self.sections[section]] {
                return expanded ? self.sortBy.count : 1
            } else {
                return 1
            }
        default:
            //General Features
            if self.isCategoriesVisible == true {
                return categories.count
            } else {
                return 5
            }
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            //Price
            var segmentCell = tableView.dequeueReusableCellWithIdentifier("segmentCell") as UITableViewCell
            return segmentCell
        case 1:
            //Most Popular
            var switchCell = tableView.dequeueReusableCellWithIdentifier("switchCell") as FilterSwitchTableViewCell
            
            switchCell.filterNameLabel.text = "Offering a Deal"
            
            switchCell.delegate = self
            switchCell.filterSwitchIsOn.setOn(filtersObj.isbestDeal!, animated: true)
            return switchCell
        case 2:
            //Radius
            var dropDownCell = tableView.dequeueReusableCellWithIdentifier("dropDownCell") as DropDownTableViewCell
            if let expanded = isExpanded[self.sections[indexPath.section]] {
                dropDownCell.filterNameLabel.text = expanded ? self.radius[indexPath.row] : self.radius[filtersObj.radius!]
            } else {
                dropDownCell.filterNameLabel.text = self.radius[filtersObj.radius!]
            }
            return dropDownCell
        case 3:
            //Sort By
            var dropDownCell = tableView.dequeueReusableCellWithIdentifier("dropDownCell") as DropDownTableViewCell
            
            if let expanded = isExpanded[self.sections[indexPath.section]] {
                dropDownCell.filterNameLabel.text = expanded ? self.sortBy[indexPath.row] : self.sortBy[filtersObj.sortBy!]
            } else {
                dropDownCell.filterNameLabel.text = self.sortBy[filtersObj.sortBy!]
            }
            
            return dropDownCell
        default:
            //General Features
            
            if self.isCategoriesVisible == false && indexPath.row == 4 {
                var viewMoreCell = tableView.dequeueReusableCellWithIdentifier("viewMoreCell") as UITableViewCell
                
                return viewMoreCell
                
            } else {
                var switchCell = tableView.dequeueReusableCellWithIdentifier("switchCell") as FilterSwitchTableViewCell
                
                //println("\(indexPath.row)")
                switchCell.filterNameLabel.text = categories[indexPath.row]
                
                switchCell.delegate = self
                
                
                if let cat = filtersObj.categoriesDictionary {
                    switchCell.filterSwitchIsOn.setOn(cat[categories[indexPath.row]]!, animated: true)
                } else {
                    // no userInfo dictionary present
                }
                return switchCell
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            //Sort by price - not available from Yelp
            break
        case 1:
            //Most Popular
            break
        case 2:
            //Radius
            if let expanded = isExpanded[self.sections[indexPath.section]] {
                isExpanded[self.sections[indexPath.section]] = !expanded
                
                self.filtersObj.radius = expanded ? indexPath.row : self.filtersObj.radius
            } else {
                isExpanded[self.sections[indexPath.section]] = true
            }
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            
        case 3:
            //Sort By
            if let expanded = isExpanded[self.sections[indexPath.section]] {
                isExpanded[self.sections[indexPath.section]] = !expanded
                
                filtersObj.sortBy = expanded ? indexPath.row : filtersObj.sortBy
            } else {
                isExpanded[self.sections[indexPath.section]] = true
            }
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            //General Features
            
            if self.isCategoriesVisible == false && indexPath.row == 4 {
                self.isCategoriesVisible = true
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
        }
    }
    
    func filterSwitchCell(filterSwitchCell: FilterSwitchTableViewCell, didChangeValue value: Bool) {
        var indexPath = self.filtersTableView.indexPathForCell(filterSwitchCell) as NSIndexPath!
        
        switch indexPath.section {
        case 0:
            //Sort by price - not available from Yelp
            println("")
        case 1:
            //Most Popular
            filtersObj.isbestDeal = value
        case 2:
            //Radius
            println("")
        case 3:
            //Sort By
            println("")
        default:
            //General Features
            //filterObj.categoriesDictionary[categories[indexPath.row]]! = value
            
            if let cat = filtersObj.categoriesDictionary {
                filtersObj.categoriesDictionary?[categories[indexPath.row]]! = value
            } else {
                // no userInfo dictionary present
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

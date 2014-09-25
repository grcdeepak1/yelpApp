//
//  RestaurantCell.swift
//  yelpApp
//
//  Created by Deepak on 9/25/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbView: UIImageView!
    @IBOutlet var catLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var numReviewsLabel: UILabel!
    @IBOutlet var starView: UIImageView!
    var restaurant : Restaurant! {
        willSet(restaurant) {
            nameLabel.text      = restaurant.name
            catLabel.text       = restaurant.categories
            addressLabel.text   = restaurant.address
            numReviewsLabel.text = String(restaurant.numReviews) + " reviews"
            thumbView.setImageWithURL(NSURL(string:  restaurant.thumbUrl))
            starView.setImageWithURL(NSURL(string:  restaurant.ratingUrl))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //nameLabel.text = restaurant.name
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

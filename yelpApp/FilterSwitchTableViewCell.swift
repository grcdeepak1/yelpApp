//
//  FilterSwitchTableViewCell.swift
//  yelpApp
//
//  Created by Deepak on 9/25/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

protocol FilterSwitchCellDelegate {
    func filterSwitchCell(filterSwitchCell: FilterSwitchTableViewCell, didChangeValue value: Bool) -> Void
}
class FilterSwitchTableViewCell: UITableViewCell {

    @IBOutlet var filterNameLabel: UILabel!
    @IBOutlet var filterSwitchIsOn: UISwitch!
    var delegate: FilterSwitchCellDelegate?
    
    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        println("value changed")
        delegate?.filterSwitchCell(self, didChangeValue: filterSwitchIsOn.on)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

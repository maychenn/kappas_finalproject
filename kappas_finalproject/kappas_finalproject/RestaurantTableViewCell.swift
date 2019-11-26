//
//  RestaurantTableViewCell.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/25/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit
import CoreData
import os.log


class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    //@IBOutlet var imageView: UIImageView!
    //static let reuseIdentifier = "RestaurantCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by Pang Yen on 2019/5/27.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

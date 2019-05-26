//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Pang Yen on 2019/5/26.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    @IBOutlet var headerimageView: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            typeLabel.layer.cornerRadius = 5
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
            
        }
    }
}

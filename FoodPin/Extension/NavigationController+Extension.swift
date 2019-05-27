//
//  NavigationController+Extension.swift
//  FoodPin
//
//  Created by Pang Yen on 2019/5/27.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}



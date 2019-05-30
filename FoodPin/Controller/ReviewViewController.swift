//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Pang Yen on 2019/5/27.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    var restaurant: RestaurantMO!
    
    @IBOutlet var rateButtons: [UIButton]!
    
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let restaurantImage = restaurant.image {
            backgroundImageView.image = UIImage(data: restaurantImage)
        }
        
        //套用模糊效果
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveRightTransform = CGAffineTransform(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform(scaleX: 5, y: 5)
        let moveScaleTransform = moveRightTransform.concatenating(scaleUpTransform)
        
        for button in rateButtons {
            button.transform = moveScaleTransform
            button.alpha = 0
        }
        
        let moveUpTransform = CGAffineTransform(translationX: 0, y: -100)
        closeButton.transform = moveUpTransform
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for index in 0..<rateButtons.count {
            UIView.animate(withDuration: 5, delay: Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: {
                self.rateButtons[index].alpha = 1
                self.rateButtons[index].transform = .identity
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 5) {
            self.closeButton.transform = .identity
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

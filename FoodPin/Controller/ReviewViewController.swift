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
    var restaurant = Restaurant()
    
    @IBOutlet var rateButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        //套用模糊效果
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveRightTransform = CGAffineTransform(translationX: 600, y: 0)
        
        for button in rateButtons {
            button.transform = moveRightTransform
            button.alpha = 0
            print(button.frame, button.bounds)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for index in 0..<rateButtons.count {
            UIView.animate(withDuration: 4, delay: Double(index), options: [], animations: {
                self.rateButtons[index].alpha = 1
                self.rateButtons[index].transform = .identity
            }, completion: nil)
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

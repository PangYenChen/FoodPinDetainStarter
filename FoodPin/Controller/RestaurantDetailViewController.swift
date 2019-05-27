//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 13/8/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    @IBOutlet var tableView: UITableView!
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never


        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.heartImageView.isHidden = !restaurant.isVisited

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none


        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white


        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension RestaurantDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let identifier = String(describing: RestaurantDetailIconTextCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named: "phone")
            cell.shortTextLabel.text = restaurant.phone
            cell.selectionStyle = .none
            
            return cell
            
        case 1:
            let identifier = String(describing: RestaurantDetailIconTextCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named: "map")
            cell.shortTextLabel.text = restaurant.location
            cell.selectionStyle = .none
            
            return cell
        case 2:
            let identifier = String(describing: RestaurantDetailTextCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant.description
            cell.selectionStyle = .none
            
            return cell
        default:
            fatalError("failed to instantiate the table view cell for detail view controller")
        }
    }
    
    
}

extension RestaurantDetailViewController: UITableViewDelegate {
    
}


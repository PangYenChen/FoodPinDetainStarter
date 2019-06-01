//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Pang Yen on 2019/5/28.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController {

    var restaurant: RestaurantMO!
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameTextField: RoundTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 5
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定導覽列
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont]
        }
    }
    
    //MARK: Action Method
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        guard let name = nameTextField.text, name != "" else {
            let alertController = UIAlertController(title: "資訊不足", message: "Name欄位必填", preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(OKaction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let type = typeTextField.text , type != "" else {
            let alertController = UIAlertController(title: "資訊不足", message: "Type欄位必填", preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(OKaction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let phone = phoneTextField.text, phone != "" else {
            let alertController = UIAlertController(title: "資訊不足", message: "Phone欄位必填", preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(OKaction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let location = addressTextField.text, location != "" else {
            let alertController = UIAlertController(title: "資訊不足", message: "Address欄位必填", preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(OKaction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let description = descriptionTextView.text, description != "" else {
            let alertController = UIAlertController(title: "資訊不足", message: "Description欄位必填", preferredStyle: .alert)
            let OKaction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertController.addAction(OKaction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        print("Name: \(name)")
        print("Type: \(type)")
        print("Location: \(location)")
        print("Phone: \(phone)")
        print("Description: \(description)")
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = name
            restaurant.type = type
            restaurant.location = location
            restaurant.phone = phone
            restaurant.summary = description
            restaurant.isVisited = false
            
            if let restaurantImage = photoImageView.image {
                restaurant.image = restaurantImage.pngData()
            }
            
            print("Saving data to context")
            appDelegate.saveContext()
        }
        
        
        
        
        
//        performSegue(withIdentifier: "unwindToHome", sender: self)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 0 else {
            return
        }
        
        let photoSourceRequestController = UIAlertController(title: "", message: "choose your photo source", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        photoSourceRequestController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        photoSourceRequestController.addAction(photoLibraryAction)
        
        if let popoverController = photoSourceRequestController.popoverPresentationController,
            let cell = tableView.cellForRow(at: indexPath) {
            popoverController.sourceView = cell
            popoverController.sourceRect = cell.bounds
        }
        
        present(photoSourceRequestController, animated: true, completion: nil)
        
    }
    
}


extension NewRestaurantController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}


extension NewRestaurantController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleToFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView
            , attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView
            , attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView
            , attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView
            , attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        
        dismiss(animated: true, completion: nil)
    }
}



extension NewRestaurantController: UINavigationControllerDelegate {}

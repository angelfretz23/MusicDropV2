//
//  NewUserTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/28/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class NewUserTableViewController: UITableViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profileDescriptionTextField: UITextView!
    
    let userController = UserController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func profileImageViewTapped(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        profileDescriptionTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Select a Photo Source", message: "Please select the source where you would like to upload a profile picture.", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton){
        // TODO: Segue to Apple Music Checker ViewController
    }

}

extension NewUserTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            guard let circleImage = image.circle else { return }
            profileImageView.image = circleImage
            let imageData = UIImageJPEGRepresentation(circleImage, 1.0)
            userController.updateProfileInfo(with: imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

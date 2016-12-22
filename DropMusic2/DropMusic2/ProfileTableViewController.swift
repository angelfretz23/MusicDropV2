//
//  ProfileTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/19/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileDescriptionTextView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = userController.user{
            updateUI(with: user)
        }
    }
    
    @IBAction func profilePicturePressed(_ sender: UITapGestureRecognizer) {
        profileDescriptionTextView.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Select a Photo Location", message: "Please choose the method in which you would like to upload a profile with.", preferredStyle: .actionSheet)
        
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
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(with user: DMUser){
        usernameLabel.text = user.username
        guard let data = user.profilePicture else { print("No Data"); return }
        profileImageView.image = UIImage(data: data )
        profileDescriptionTextView.text = user.profileDescription
    }
}

extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            guard let circleImage = image.circle else { return }
            profileImageView.image = circleImage
            let imageData = UIImageJPEGRepresentation(circleImage, 1.0)
            userController.setProfileImage(withImage: imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

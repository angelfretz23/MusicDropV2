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
    
    let descriptionTextViewCharacterLimit = 150
    
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileDescriptionTextView.delegate = self
        
        if let user = userController.user{
            updateUI(with: user)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = userController.user{
            updateUI(with: user)
        }
    }
    
    @IBAction func profilePicturePressed(_ sender: UITapGestureRecognizer) {
        profileDescriptionTextView.resignFirstResponder()
        
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
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func usernameLabelTapped(_ sender: UITapGestureRecognizer) {
        var alertControllerTextField: UITextField?
        
        let alertController = UIAlertController(title: "Change UserName", message: "What would you like your new username to be?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Username"
            alertControllerTextField = textField
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let newUsername = alertControllerTextField?.text
            self.userController.updateProfileInfo(with: nil, newUsername)
            self.usernameLabel.text = newUsername
        }
        
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(with user: DMUser){
        usernameLabel.text = user.username
        profileDescriptionTextView.text = user.profileDescription
        textCountLabel.text = "character limit: \(descriptionTextViewCharacterLimit - (user.profileDescription?.characters.count ?? 0))"
        guard let data = user.profilePicture else { print("No Data"); return }
        profileImageView.image = UIImage(data: data )
        
    }
}

extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            guard let circleImage = image.circle else { return }
            profileImageView.image = circleImage
            let imageData = UIImageJPEGRepresentation(circleImage, 1.0)
            userController.updateProfileInfo(with: imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileTableViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.characters.count + text.characters.count > 150{
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textCountLabel.text = "character limit: \(descriptionTextViewCharacterLimit - textView.text.characters.count)"

    }
}

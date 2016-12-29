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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func profileImageViewTapped(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        profileDescriptionTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
    }

}

extension NewUserTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
}

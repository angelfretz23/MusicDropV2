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
    @IBOutlet weak var profileDescriptionImageView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func profilePicturePressed(_ sender: UITapGestureRecognizer) {
        
    }
}

extension ProfileTableViewController: UIPickerViewDelegate{
    
}

//
//  NewSongTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/6/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class NewSongTableViewController: UITableViewController {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var newSongLabel: UILabel!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

//
//  CustomTabBarView.swift
//  DropMusic2
//
//  Created by Angel Contreras on 2/24/17.
//  Copyright © 2017 Angel Contreras. All rights reserved.
//

import UIKit

protocol CustomTabBarViewDelegate: class {
    func tabBarButtonTapped(index: Int)
}

class CustomTabBarView: UIView {
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    weak var delegate: CustomTabBarViewDelegate?

    
    func select(index: Int){
    }
    
    @IBAction func didTapButton(sender: UIButton){
        delegate?.tabBarButtonTapped(index: sender.tag)
    }
}

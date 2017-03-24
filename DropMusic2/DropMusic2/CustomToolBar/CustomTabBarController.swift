//
//  CustomTabBarController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 2/24/17.
//  Copyright © 2017 Angel Contreras. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, CustomTabBarViewDelegate {
    
    @IBOutlet weak var tabView: CustomTabBarView!
    
    override var selectedIndex: Int{
        didSet{
            tabView.select(index: selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        
        //Set up customTabBarView
        let frame = CGRect(x: 0, y: view.frame.height - 45, width: view.frame.width, height: 45)
        tabView.frame = frame
        tabView.select(index: 0)
        tabView.delegate = self
        view.addSubview(tabView)
    }
    
    func tabBarButtonTapped(index: Int) {
        selectedIndex = index
    }
}

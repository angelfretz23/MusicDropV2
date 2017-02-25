//
//  CustomTabBarView.swift
//  DropMusic2
//
//  Created by Angel Contreras on 2/24/17.
//  Copyright © 2017 Angel Contreras. All rights reserved.
//

import UIKit

class CustomTabBarView: UIView {

    var imageView0 = UIImageView()
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    var imageView3 = UIImageView()
    var arrayOfImageViews = [UIImageView]()
    
    var button0 = UIButton()
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()

    override init(frame: CGRect){
        super.init(frame: frame)
        
        button0.tag = 0
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectIndex(index: Int){
        //Set all to defaults (unselected)
        imageView0.tintColor = UIColor.white
        
    }
}

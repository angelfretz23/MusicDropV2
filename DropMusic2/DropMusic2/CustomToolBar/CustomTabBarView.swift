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
    
    var button0 = UIButton()
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var arrayOfButtons = [UIButton]()
    
    weak var delegate: CustomTabBarViewDelegate?

    override init(frame: CGRect){
        super.init(frame: frame)
        arrayOfButtons += [button0, button1, button2, button3]
        
        var x = 0
        arrayOfButtons.forEach { (button) in
            button.tag = x
            x += 1
        }
        
        arrayOfButtons.forEach { (button) in
            button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(index: Int){
        //TODO: - Change tint color base on selectIndex
        
    }
    
    func didTapButton(sender: UIButton){
        select(index: sender.tag)
        delegate?.tabBarButtonTapped(index: sender.tag)
    }
}

//
//  DMMediaItem.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

protocol DMMediaItem{
    var storeID: String { get set }
    var mediaType: String { get }
    
    func isEqualTo(other: DMMediaItem) -> Bool
}

func ==(left: DMMediaItem, right: DMMediaItem) -> Bool{
    return left.storeID == right.storeID
}

//
//  DMUser.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMUser{
    let username: String
    let profilePicture: Data?
    let profileDescription: String?
    let uuid: UUID
    let cloudID: String?
    
    init(username: String, profilePicture: Data?, profileDescription: String?, uuid: UUID, cloudID: String? = nil){
        self.username = username
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.uuid = uuid
        self.cloudID = cloudID
    }
}

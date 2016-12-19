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
    
    private let kUsername = "Username"
    private let kProfilePicture = "ProfilePicture"
    private let kProfileDescription = "ProfileDescription"
    private let kUUID = "UUID"
    private let kcloudID = "CloudID"
    
    var dictionaryRepresentation: [String: Any?]{
        return [kUsername : self.username, kProfilePicture : self.profilePicture, kProfileDescription: self.profileDescription, kUUID: self.uuid, kcloudID: self.cloudID]
        
    }
    
    init(username: String, profilePicture: Data?, profileDescription: String?, uuid: UUID, cloudID: String? = nil){
        self.username = username
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.uuid = uuid
        self.cloudID = cloudID
    }
    
    init?(dictionary: [String: Any]){
        guard let username = dictionary[kUsername] as? String,
        let profilePicture = dictionary[kProfilePicture] as? Data?,
        let profileDescription = dictionary[kProfileDescription] as? String?,
        let uuid = dictionary[kUUID] as? UUID,
            let cloudID = dictionary[kcloudID] as? String? else { return nil }
        
        self.username = username
        self.profilePicture = profilePicture
        self.profileDescription = profileDescription
        self.uuid = uuid
        self.cloudID = cloudID
    }
    
    
}

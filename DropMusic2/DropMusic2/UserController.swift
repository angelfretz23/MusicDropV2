//
//  UserController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/19/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class UserController{
    
    private(set) var user: DMUser?
    
    private let kUser = "User"
    
    init(){
        
        loadFromPersistStore()
        if self.user ==  nil{
            self.user = DMUser(username: "Angelfretz", profilePicture: nil, profileDescription: "Hello, my name is Angel!", uuid: UUID(), cloudID: "Cloudnumber")
        }
    }
    
    deinit {
        saveToPersistStore()
    }
    
    func createUser(_ user: DMUser){
        self.user = user
        saveToPersistStore()
    }
    
    func saveToPersistStore(){
        guard let user = user else { return }
        UserDefaults.standard.set(user.dictionaryRepresentation, forKey: kUser)
    }
    
    func loadFromPersistStore(){
        guard let userDictionary = UserDefaults.standard.object(forKey: kUser) as? [String: Any] else { return }
        self.user = DMUser(dictionary: userDictionary)
    }
    
    func updateProfileInfo(with imageData: Data? = nil, _ username: String? = nil, _ profileDescription: String? = nil){
        if let imageData = imageData {
            self.user?.profilePicture = imageData
        }
        
        if let username = username{
            self.user?.username = username
        }
        
        if let profileDescription = profileDescription{
            self.user?.profileDescription = profileDescription
        }
        
        saveToPersistStore()
    }
}

//
//  UserController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/19/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class UserController{
    
    private(set) var user: DMUser?{
        didSet{
            GCDController().backgroundThread(background: { 
                self.saveToPersistStore()
            }, completion: nil)
        }
    }
    
    private let kUser = "User"
    
    init(){
        loadFromPersistStore()
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
        guard let userDictionary = UserDefaults.standard.object(forKey: kUser) as? [String: Any?] else { return }
        self.user = DMUser(dictionary: userDictionary)
    }
}

//
//  PostController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/12/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class PostController{
    
    static let sharedController = PostController()
    
    private(set) var posts: [DMPost] = []{
        didSet{
            let postsChangedNotification = Notification.Name(rawValue: "PostsChangedNotification")
            NotificationCenter.default.post(name: postsChangedNotification, object: nil)
        }
    }
    
    func createPost(_ post: DMPost, completion: ((DMPost) -> Void)?) {
        posts.append(post)
    }
}

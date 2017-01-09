//
//  FeedTableViewCell.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/5/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var echosCollectionView: UICollectionView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var comments: [DMComment]? = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    func updateWith(post: DMPost){
        
        songNameLabel.text = post.song.title
        artistNameLabel.text = post.song.artist
        descriptionLabel.text = post.description
        self.comments = post.comments
        let url = post.song.albumCoverStringURL.replacingOccurrences(of: "100", with: "150")
        
        ImageController.fetchImage(withString: url){ (image) in
            self.albumCoverImageView.image = image
        }
        guard let user = UserController().user else { return }
        
        if post.userUUID == user.uuid {
            userProfileImageView.image = UIImage(data: user.profilePicture!)
            usernameLabel.text = user.username
        }
    }
}

extension FeedTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        
        
        return cell 
    }
}

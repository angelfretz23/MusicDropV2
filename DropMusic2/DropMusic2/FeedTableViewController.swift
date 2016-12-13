//
//  FeedTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/28/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let postsChangedNotification = Notification.Name(rawValue: "PostsChangedNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: postsChangedNotification, object: nil)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Fetch posts
        return PostController.sharedController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell

        let post = PostController.sharedController.posts[indexPath.row]
        cell?.updateWith(post: post)

        return cell ?? FeedTableViewCell()
    }

    func updateUI(){
        self.tableView.reloadData()
    }
}

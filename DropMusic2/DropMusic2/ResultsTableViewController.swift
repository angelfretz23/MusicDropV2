//
//  ResultsTableViewController.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

protocol ResultsTableViewControllerDelegate: class {
    func didSelectSong(song: DMSong)
}

class ResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    weak var delegate: ResultsTableViewControllerDelegate?
    
    var mediaItems: [DMMediaItem] = []

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return mediaItems.filter{$0.mediaType == "track"}.count
        } else {
            return mediaItems.filter{$0.mediaType == "collection"}.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if mediaItems.count == 0{
            return nil
        } else {
            if section == 0{
                return "Songs"
            } else {
                return "Albums"
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultTableViewCell

        let index = (indexPath.section * mediaItems.filter{$0.mediaType == "track"}.count) + indexPath.row
        let mediaItem = mediaItems[index]
        cell?.updateCellWith(mediaItem: mediaItem)

        return cell ?? ResultTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (indexPath.section * mediaItems.filter{$0.mediaType == "track"}.count) + indexPath.row
        let media = mediaItems[index]
        if media.mediaType ==  "track"{
            guard let song = media as? DMSong else { return }
            
            let chosenNameNotificationName = NSNotification.Name(rawValue: "chosenSong")
            NotificationCenter.default.post(name: chosenNameNotificationName, object: song)
            
            let notificationName = NSNotification.Name.init("SongHasBeenSelected")
            NotificationCenter.default.post(name: notificationName, object: nil)
            self.dismiss(animated: true, completion: nil)
        } else if media.mediaType == "collection"{
            self.presentingViewController?.performSegue(withIdentifier: "albumDetailFromSearchController", sender: media)
        }
    }

}

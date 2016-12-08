//
//  ResultTableViewCell.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCellWith(mediaItem: DMMediaItem){
        if mediaItem.mediaType == "track"{
            guard let song = mediaItem as? DMSong else { return }
            songNameLabel.text = song.title
            artistNameLabel.text = song.artist
            
            ImageController.fetchImage(withString: song.albumCoverStringURL, completion: { (image) in
                self.albumCoverImageView.image = image
            })
        } else if mediaItem.mediaType == "collection" {
            guard let album = mediaItem as? DMAlbum else { return }
            songNameLabel.text = album.title
            artistNameLabel.text = album.artist
            
            ImageController.fetchImage(withString: album.coverURL, completion: { (image) in
                self.albumCoverImageView.image = image
            })
        }
    }
}

//
//  TopChartsTableViewCell.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class TopChartsTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellWith(song: DMSong, at row: Int){
        rankLabel.text = "\(row)"
        songNameLabel.text = song.title
        artistNameLabel.text = song.artist
        
        ImageController.fetchImage(withString: song.albumCoverStringURL){ (image) in
            self.albumCoverImageView.image = image
        }
    }

}

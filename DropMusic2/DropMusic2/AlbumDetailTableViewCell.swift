//
//  AlbumDetailTableViewCell.swift
//  DropMusic2
//
//  Created by Angel Contreras on 12/7/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateWith(song: DMSong, at row: Int){
        trackNumberLabel.text = "\(row)"
        songTitleLabel.text = song.title
    }

}

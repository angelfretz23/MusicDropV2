//
//  DMSong.swift
//  DropMusic2
//
//  Created by Angel Contreras on 11/27/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import Foundation

class DMSong: DMMediaItem{
    let title: String
    let artist: String
    let collectionID: Double
    var storeID: Double
    let albumCoverStringURL: String
    let trackTime: Double
    var mediaType: String = "track"
    
    init(title: String, artist: String, collectionID: Double, storeID: Double, albumCoverStringURL: String, trackTime: Double){
        self.title = title
        self.artist = artist
        self.collectionID = collectionID
        self.storeID = storeID
        self.albumCoverStringURL = albumCoverStringURL
        self.trackTime = trackTime
    }
}
